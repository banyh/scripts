## 建立新的 Conda Environment

```
conda create -n website
conda install -c conda-forge -y fastapi
conda install -c conda-forge -y uvicorn
conda activate website
```

## 建立後端

```
mkdir -p web/backend
cd web/backend
```

在`web/backend`目錄下，新增`main.py`，內容如下
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}
```

然後啟動App
```
uvicorn main:app --reload
```
就可以在 http://127.0.0.1:8000/ 看到 `{"Hello": "World"}`

## 建立前端

先回到 `web/` 目錄下
```
flutter create -t app --platforms web frontend
cd frontend
flutter build web
cp -avr build/web ../backend
```

回到 `web/backend` 目錄下，修改一下 `main.py`
```python
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

api_app = FastAPI()

@api_app.get("/")
def read_root():
    return {"Hello": "World"}

app = FastAPI()
app.mount('/api', api_app)  # this line should be placed before mounting static files
app.mount('/', StaticFiles(directory="web", html=True), name="web")
```

## 檢查是否一切順利

* 前端產生的靜態檔案，是放在`frontend/build/web`，而不是`frontend/web`，複製時不要複製錯
* 打開 http://127.0.0.1:8000/ 應該能看到 Flutter demo site，右下角有一個 + 按鈕可以增加counter
* 打開 http://127.0.0.1:8000/api/ 應該看到 `{"Hello": "World"}`
* 打開 http://127.0.0.1:8000/api/docs 應該看到 Swagger UI 自動產生的 API 文件

## 開發須知

* 開發 Flutter 時，是用 `flutter run` 搭配 chrome 產生隨機 port 的臨時頁面。`flutter build web` 是準備要 deploy 時才會用
* 因為臨時前端頁面的 port 不是8000，所以需要參考 https://fastapi.tiangolo.com/tutorial/cors/ 設定後端的 CORS，才能確保 API 能收到
* 無論 Flutter 或是 uvicorn + fastapi，都支援修改後自動 reload，不需要將 server 關掉重開
