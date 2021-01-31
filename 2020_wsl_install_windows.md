# 在Window中如何開啟 Winsow Subsystem for Linux (WSL)

1. 在「更新與安全性」中，加入開發人員計劃，選擇**Dev通道**

2. 在「更新與安全性」中，更新Windows Update到最新版本 (版本 >= 2004，OS組建 >= 19041)，可以執行`winver`來確認版本

3. 以系統管理員身分開啟 PowerShell，執行指令後，重啟電腦

    ```
    wsl --install
    ```

4. 重新啟動後，應該已經裝好Ubuntu，可以在開始功能表中找到，第一次執行後會要求輸入使用者帳號及密碼

    * 在WSL作業系統中，檔案的owner只有兩種：使用者或是root

5. 到 https://developer.nvidia.com/cuda/wsl 下載CUDA Driver，這個driver會同時安裝在Windows及WSL，所以能讓WSL中使用CUDA

    * 安裝前要確定，WSL2的kernel版本 >= 4.19.121

6. 在WSL中，安裝對應的CUDA toolkit

   * 注意：不要安裝 `cuda, cuda-11-0, cuda-drivers` 等套件，只能安裝 `cuda-toolkit-11-0`

    ```
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
    apt-get update
    apt-get install -y cuda-toolkit-11-0
    ```

7. 如果需要用Docker，只能在Window端安裝

    * 參考這裡的安裝方式 https://docs.docker.com/docker-for-windows/wsl/
