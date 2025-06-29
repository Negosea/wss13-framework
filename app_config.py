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
