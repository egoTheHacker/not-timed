
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
import uvicorn

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_credentials=True,
    allow_origins=['*'],
    allow_methods=['*'],
    allow_headers=['*'],
)

@app.get('/api')
async def api() -> dict:
    return dict(message="hola, k ase")


try:
    print('Intentando montar statics...')
    app.mount('', StaticFiles(directory='frontend/build', html=True), name='static')
except RuntimeError as e:
    print(f'Puede que dist no exista. [Error]: {e}')

if __name__ == "__main__":
    uvicorn.run("main:app", host='0.0.0.0', port=5000, log_level="info")
