1. 在「更新與安全性」中，加入開發人員計劃，選擇**Dev通道**

2. 在「更新與安全性」中，更新Windows Update到最新版本 (版本 >= 2004，OS組建 >= 19041)，可以執行`winver`來確認版本

3. 以系統管理員身分開啟 PowerShell，執行以下兩個指令後，重啟電腦

    ```
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```

4. 重啟後，以系統管理員身分開啟 PowerShell，執行以下指令

    ```
    wsl --set-default-version 2
    ```

5. 會出現訊息，叫你去 https://aka.ms/wsl2kernel 下載kernel，就去下載並安裝

6. 開啟Windows Store，搜尋`linux`，並且安裝最喜歡的版本 (例如我安裝 Ubuntu 20.04)

7. 安裝後，可以在開始功能表中找到Ubuntu 20.04，執行後會要求輸入使用者帳號及密碼

    * 在WSL作業系統中，檔案的owner只有兩種：使用者或是root

8. 到 https://developer.nvidia.com/cuda/wsl 下載CUDA Driver，這個driver會同時安裝在Windows及WSL，所以能讓WSL中使用CUDA

    * 安裝前要確定，WSL2的kernel版本 >= 4.19.121

9. 在WSL中，安裝對應的CUDA toolkit

    ```
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
    sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
    apt-get update
    apt-get install -y cuda-toolkit-11-0
    ```
