Assuming your conda env is named **tmp**

```
conda activate tmp
conda install ipykernel
ipython kernel install --user --name=tmp_env
conda deactivate
```

Restart or refresh jupyter-lab to see the new kernel available.
