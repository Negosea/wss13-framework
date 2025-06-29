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
