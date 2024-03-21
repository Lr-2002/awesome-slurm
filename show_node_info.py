#! /usr/bin/python
import subprocess
import re
def get_all_node_names():
    command = "scontrol show nodes"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    node_lines = [line for line in result.stdout.split('\n') if line.startswith("NodeName=")]

    # 提取节点名称
    node_names = [line.split("=")[1].split(' ')[0] for line in node_lines]

    return node_names

def get_node_info(node_name):
    command = f"scontrol show node {node_name}"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    return result.stdout
def extract_gres_info(node_info):
    # 使用正则表达式提取 GRES/GPU 信息
    cfgtres_match = re.search(r'CfgTRES=.*?gres/gpu=(\d+)', node_info)
    alloc_match = re.search(r'AllocTRES=.*?gres/gpu=(\d+)', node_info)

    if cfgtres_match and alloc_match:
        cfgtres_gpu_count = int(cfgtres_match.group(1))
        alloc_gpu_count = int(alloc_match.group(1))
        return cfgtres_gpu_count, alloc_gpu_count
    else:
        return None, None


def analyze_nodes(nodes):
    for node in nodes:
        node_info = get_node_info(node)
        total, alloced = extract_gres_info(node_info)
        # 在这里可以添加分析节点信息的逻辑
        # 例如，提取 GPU 空闲数量等信息
        print(f"Node: {node}\n {alloced}/{total}\n{'='*30}")

if __name__ == "__main__":
    # 在这里设置要查询的节点名称列表
    #node_names = ["hgx-hyperplane03"]
    node_names = get_all_node_names() 
    #print(node_names)
    # 使用 tqdm 创建进度条
    #with tqdm(total=len(node_names), desc="Analyzing Nodes", unit="node") as pbar:
    for node_name in node_names:
         # 在每个节点处理完成后更新进度条
        analyze_nodes([node_name])
        #pbar.update(1)

    print("Analysis complete.")

