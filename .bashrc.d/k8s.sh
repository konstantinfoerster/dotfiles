alias k=kubectl
alias kwRestarts="watch \"kubectl get po | awk '\\\$4>0'\""
alias kEvents="kubectl get events --sort-by=.metadata.creationTimestamp"
alias kc="k config current-context"
source <(kubectl completion bash)
complete -F __start_kubectl k
