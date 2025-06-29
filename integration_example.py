# EXEMPLO DE COMO INTEGRAR NO SEU main.py EXISTENTE

from fastapi import FastAPI
from app_config import configure_app

# Criar instância do FastAPI
app = FastAPI(
    title="WSS13 Framework API",
    description="Framework revolucionário para construção civil",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Aplicar todas as configurações de segurança e performance
app = configure_app(app)

# Suas rotas existentes continuam funcionando normalmente
@app.get("/")
async def root():
    return {"message": "WSS13 Framework - Seguro e Otimizado"}

@app.get("/health")
async def health_check():
    return {"status": "healthy", "framework": "wss13"}
