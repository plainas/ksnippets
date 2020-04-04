function kget_all_label_values -d "Get all kubernetes pods labels and their valies"
    kubectl get pods --no-headers --show-labels|awk '{print $NF}'| sed 's/,/\n/g'| sort| uniq
end


function kget_all_labels -d "get all labels"
    kubectl get pods --no-headers --show-labels|awk '{print $NF}'| sed 's/,/\n/g'| grep -oP '^[^=]*'| sort | uniq
end


function kget_label_values -d "get all values for a label"
    kubectl get pods --no-headers --show-labels|awk '{print $NF}'| sed 's/,/\n/g'| sort| uniq | grep '^app='| sed 's/.*=//g'
end


function kdelete_pod -d "delete pods interactively (percol)"
    kubectl get pods | percol| awk '{print $1}'| xargs kubectl delete pods
end


function kget_pod_image -d "get image for pod"
    kubectl get pods | percol| awk '{print $1}'| xargs -i'FOO' kubectl get pods FOO -o jsonpath='{..image}'| sed 's/ /\n/g'| sort| uniq
end


function kenv -d "get envioronment for pod"
    kubectl get pods | percol| awk '{print $1}'| xargs -i'FOO' kubectl exec FOO -- printenv| sort
end