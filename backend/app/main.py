from fastapi import FastAPI

app = FastAPI(title="Gerador de Leads API")


@app.get("/")
def read_root():
    return {"message": "API do Gerador de Leads no ar"}
