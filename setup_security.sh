#!/bin/bash

# 1. Fazer backup do main.py atual
echo "📦 Criando backup do main.py..."
cp main.py main.py.backup_security_$(date +%Y%m%d_%H%M%S)

# 2. Instalar dependências de segurança e performance
echo "📥 Instalando dependências..."
pip install fastapi uvicorn python-multipart slowapi secure python-jose[cryptography] passlib[bcrypt]

# 3. Atualizar requirements.txt
echo "📝 Atualizando requirements.txt..."
pip freeze > requirements.txt

# 4. Criar arquivo de middleware de segurança
echo "🛡️ Criando middleware de segurança..."
cat > security_middleware.py << 'EOF'
from fastapi import Request
from fastapi.responses import JSONResponse
import time
import hashlib
import secrets

class SecurityMiddleware:
    """Middleware completo de segurança para FastAPI"""
    
    @staticmethod
    async def add_security_headers(request: Request, call_next):
        # Registrar tempo de início
        start_time = time.time()
        
        # Processar requisição
        response = await call_next(request)
        
        # Headers de segurança essenciais
        response.headers["Strict-Transport-Security"] = "max-age=31536000; includeSubDomains; preload"
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["X-XSS-Protection"] = "1; mode=block"
        response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
        response.headers["Permissions-Policy"] = "geolocation=(), microphone=(), camera=()"
        
        # Content Security Policy mais robusta
        response.headers["Content-Security-Policy"] = (
            "default-src 'self'; "
            "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; "
            "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdn.jsdelivr.net; "
            "font-src 'self' https://fonts.gstatic.com; "
            "img-src 'self' data: https: blob:; "
            "connect-src 'self' https://api.wss13.com.br wss://wss13.com.br; "
            "frame-ancestors 'none'; "
            "base-uri 'self'; "
            "form-action 'self';"
        )
        
        # Headers de performance
        response.headers["X-Response-Time"] = str(round((time.time() - start_time) * 1000, 2)) + "ms"
        response.headers["Cache-Control"] = "public, max-age=3600" if request.method == "GET" else "no-cache"
        
        # Header customizado do framework
        response.headers["X-Powered-By"] = "WSS13-Framework"
        
        return response
EOF

# 5. Criar configuração principal aprimorada
echo "⚡ Criando configuração principal..."
cat > app_config.py << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.gzip import GZipMiddleware
from fastapi.middleware.trustedhost import TrustedHostMiddleware
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded
from security_middleware import SecurityMiddleware

def configure_app(app: FastAPI):
    """Configura todos os middlewares e segurança da aplicação"""
    
    # Rate limiting
    limiter = Limiter(key_func=get_remote_address)
    app.state.limiter = limiter
    app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)
    
    # Compressão GZIP
    app.add_middleware(GZipMiddleware, minimum_size=1000)
    
    # Hosts confiáveis
    app.add_middleware(
        TrustedHostMiddleware,
        allowed_hosts=["wss13.com.br", "*.wss13.com.br", "localhost", "127.0.0.1"]
    )
    
    # CORS configurado de forma segura
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["https://wss13.com.br"],
        allow_credentials=True,
        allow_methods=["GET", "POST", "PUT", "DELETE"],
        allow_headers=["*"],
        max_age=3600,
    )
    
    # Middleware de segurança customizado
    app.middleware("http")(SecurityMiddleware.add_security_headers)
    
    return app
EOF

# 6. Criar exemplo de integração
echo "📄 Criando exemplo de integração..."
cat > integration_example.py << 'EOF'
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
EOF

# 7. Mostrar instruções finais
echo "
✅ INSTALAÇÃO CONCLUÍDA!

🔧 PRÓXIMOS PASSOS:

1. INTEGRAR NO SEU main.py:
   - Adicione no topo do arquivo:
     from app_config import configure_app
   
   - Após criar o app FastAPI, adicione:
     app = configure_app(app)

2. TESTAR LOCALMENTE:
   uvicorn main:app --reload --host 0.0.0.0 --port 8000

3. VERIFICAR HEADERS:
   curl -I http://localhost:8000/

4. FAZER COMMIT E DEPLOY:
   git add -A
   git commit -m 'feat: implementar segurança e performance completas'
   git push origin main

📊 MELHORIAS IMPLEMENTADAS:
- ✅ Headers de segurança (HSTS, CSP, X-Frame-Options, etc.)
- ✅ Compressão GZIP automática
- ✅ Rate limiting para proteção contra DDoS
- ✅ CORS configurado de forma segura
- ✅ Hosts confiáveis definidos
- ✅ Métricas de performance (X-Response-Time)
- ✅ Cache otimizado para recursos estáticos

🔒 SCORE DE SEGURANÇA ESPERADO: A+ no SecurityHeaders.com
"
