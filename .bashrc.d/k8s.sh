alias k=kubectl
alias kge="kubectl get events --sort-by=.metadata.creationTimestamp"
alias kgp="kubectl get pods"
alias kgps="kubectl get pods --sort-by=.metadata.creationTimestamp"
alias kl1m='kubectl logs --since 1m'
alias klf1m='kubectl logs --since 1m -f'
alias kc="k config current-context"

source <(kubectl completion bash)
complete -F __start_kubectl k
