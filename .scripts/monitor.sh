#!/bin/bash
# This script is called as root and without X knowledge

export DISPLAY=:0
export XAUTHORITY=/home/kg/.Xauthority

XRANDR="xrandr"
CMD="$XRANDR"
DEFAULT_DISPLAY="LVDS1"
connectedDisplays=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
displayCount=`echo $connectedDisplays | wc --words`

configureWorkspaces() {
    echo "@Deprecated configureWorkspaces"
	let i=1
    for monitor in $(bspc query -M); do
        bspc monitor $monitor \
           -n "$i" \
           -d {I,II,III,IV,V}
           let i++
    done
    unset i
}

beforeDisplay=""
buildDisplayCmd() {
	local display=${1}
	if [[ "${2}" == 'connected' ]]; then
		#if [[ $display == $DEFAULT_DISPLAY ]] && [[ $displayCount > 2 ]]; then		
			#deactivate internal display
        #                CMD="${CMD} --output $display --off"
	#	else
			local displayPositon=""
			if [[ -n $beforeDisplay ]]; then
				displayPosition=" --left-of $beforeDisplay"
			fi
			CMD="${CMD} --output $display --auto $displayPosition"
			beforeDisplay=$display
	#	fi
	else
		CMD="${CMD} --output ${1} --off"
	fi	
}

configureDisplays() {
	local -A VOUTS
	eval VOUTS=$($XRANDR | awk 'BEGIN {printf("(")} /^\S.*connected/{printf("[%s]=%s ", $1, $2)} END{printf(")")}')

	for VOUT in ${!VOUTS[*]}; do
		buildDisplayCmd ${VOUT} ${VOUTS[${VOUT}]}
	done
	set -x
	$CMD
	set +x
}

onlyIntern() {
    set -x

    # maybe event isn't finished so we just wait 
    sleep 1
	
    if [ $(pgrep -fc intel-virtual-output) -gt 0   ] ; then
        echo "Killing interl-virtual-output"
        pkill -f intel-virtual-output
    fi

    local -A VOUTS
	eval VOUTS=$($XRANDR | awk 'BEGIN {printf("(")} /^\S.*connected/{printf("[%s]=%s ", $1, $2)} END{printf(")")}')
	for VOUT in ${!VOUTS[*]}; do
        if [ "${VOUT}" == "$DEFAULT_DISPLAY" ]; then
		    buildDisplayCmd ${VOUT} ${VOUTS[${VOUT}]}
        else
            buildDisplayCmd ${VOUT} "disconnected"
        fi
    done
    $CMD
    set +x
}

configureWork() {
    set -x
    sleep 1
    if [ $(pgrep -fc intel-virtual-output) -eq 0 ] ; then 
        echo "intel-virtual-output not running. Starting!"
        intel-virtual-output
    fi
    sleep 1
    .screenlayout/work_before_all.sh
    sleep 2
    .screenlayout/work_all.sh
    set +x
}

find_mode() {
    echo $(${XRANDR} |grep ${1} -A1|awk '{FS="[ x]"} /^\s/{printf("WIDTH=%s\nHEIGHT=%s", $4,$5)}')
}

swapDisplays() {
        local activeDisplays=$($XRANDR | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
        local displays=(${activeDisplays//s/ })
    
        local posis=$($XRANDR | grep -oE "[0-9]+\+[0-9]+\s")
        local posisArr=(${posis//s/ })
    
        local tmpPosD1=(${posisArr[0]//+/ })
        local tmpPosD2=(${posisArr[1]//+/ })
    
        local -A posD1
        posD1=([X]=${tmpPosD1[0]} [Y]=${tmpPosD1[1]})

        local -A posD2
        posD2=([X]=${tmpPosD2[0]} [Y]=${tmpPosD2[1]})
    
        eval $(find_mode ${displays[0]})  #sets ${WIDTH} and ${HEIGHT}
        local widthD1=$WIDTH
    
        eval $(find_mode ${displays[1]})  #sets ${WIDTH} and ${HEIGHT}
        local widthD2=$WIDTH
    
        if [ ${posD1[X]} == "0" ]; then
                posD2[X]=${posD1[X]}
                posD1[X]=$widthD2
        else    
                posD1[X]=${posD2[X]}
                posD2[X]=$widthD1
        fi  
    
        CMD="$CMD --output ${displays[0]} --auto --pos ${posD1[X]}x${posD1[Y]} --output ${displays[1]} --auto --pos ${posD2[X]}x${posD2[Y]}"
	set -x
	$CMD
	set +x
}


case "$1" in
	workspaces)
	    configureWorkspaces
	    ;;
	swap)
        swapDisplays
        ;;
    work)
        configureWork
        ;;      
    disable)
        onlyIntern
        ;;
    *)
	    configureDisplays	
 	    ;;
esac
