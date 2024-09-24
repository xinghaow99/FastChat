BASE_PATH=/home/jovyan/wxh/llm-awq/models/Meta-Llama-3.1-8B-Instruct
get_model_name_from_path() {
    local path=$1
    echo "${path##*/}"
}
for wbits in 3 4; do
for group_size in 128; do
MODEL_PATH=$BASE_PATH-w$wbits-g$group_size
model_name=$(get_model_name_from_path $MODEL_PATH)
echo $model_name
python gen_model_answer.py \
    --model-path $MODEL_PATH \
    --model-id $model_name \
    --num-gpus-total 8
done
done

for wbits in 2 3 4; do
MODEL_PATH=$BASE_PATH-w$wbits
model_name=$(get_model_name_from_path $MODEL_PATH)
echo $model_name
python gen_model_answer.py \
    --model-path $MODEL_PATH \
    --model-id $model_name \
    --num-gpus-total 8
done
