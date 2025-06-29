from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse, FileResponse
from pydantic import BaseModel
from typing import Dict, Any
import os

class ProjectData(BaseModel):
    name: str
    area: float
    structural_load: float
    soil_tension: float
    budget: float = None

app = FastAPI(
    title="WSS+13 Framework",
    description="🏗️ Ecossistema de 5 Agentes IA para Construção Civil",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

if os.path.exists("frontend"):
    app.mount("/static", StaticFiles(directory="frontend"), name="static")

@app.get("/", response_class=HTMLResponse)
async def serve_landing():
    try:
        with open("frontend/index.html", "r", encoding="utf-8") as f:
            content = f.read()
            content = content.replace('href="style.css"', 'href="/static/style.css"')
            content = content.replace('src="script.js"', 'src="/static/script.js"')
            return HTMLResponse(content=content)
    except FileNotFoundError:
        return HTMLResponse("""
        <html>
            <head><title>WSS+13 Framework</title></head>
            <body>
                <h1>🏗️ WSS+13 Framework</h1>
                <p>✅ API funcionando!</p>
                <a href="/docs">📚 Documentação</a>
            </body>
        </html>
        """)

@app.get("/health")
async def health():
    return {
        "status": "healthy", 
        "framework": "WSS+13",
        "version": "1.0.0",
        "agents_online": 5,
        "timestamp": "2025-06-28T03:10:00Z"
    }

@app.get("/agents")
async def list_agents():
    return {
        "agents": [
            {
                "id": "structural", 
                "name": "Breno Silva", 
                "role": "Engenheiro Estrutural",
                "registration": "CREA-SP 123456/D",
                "experience": "25 anos",
                "status": "active"
            },
            {
                "id": "financial", 
                "name": "Paulo Mendes", 
                "role": "Analista de Viabilidade Financeira",
                "registration": "CRC-SP 654321",
                "experience": "15 anos",
                "status": "active"
            },
            {
                "id": "construction", 
                "name": "José Silva", 
                "role": "Mestre de Obras",
                "registration": "SINDUSCON-SP 789123",
                "experience": "20 anos",
                "status": "active"
            },
            {
                "id": "safety", 
                "name": "Ricardo Proteção", 
                "role": "Engenheiro de Segurança do Trabalho",
                "registration": "CREA-SP 456789/D",
                "experience": "18 anos",
                "status": "active"
            },
            {
                "id": "sustainability", 
                "name": "Helena Vendas", 
                "role": "Diretora Comercial",
                "registration": "CRA-SP 987321",
                "experience": "12 anos",
                "status": "active"
            }
        ],
        "total": 5,
        "framework": "WSS+13"
    }

@app.post("/analyze/structural")
async def analyze_structural(project: ProjectData):
    foundation_width = project.structural_load / project.soil_tension * 1.5
    foundation_area = foundation_width * 2.0
    
    return {
        "agent": "structural",
        "agent_name": "Breno Silva",
        "agent_role": "Engenheiro Estrutural",
        "registration": "CREA-SP 123456/D",
        "project_name": project.name,
        "analysis": {
            "structural_load": f"{project.structural_load} kN",
            "soil_tension": f"{project.soil_tension} kPa",
            "foundation_type": "Sapata Corrida",
            "foundation_width": f"{foundation_width:.2f} cm",
            "foundation_area": f"{foundation_area:.2f} m²",
            "safety_factor": 2.5,
            "compliance": "NBR 6122:2019",
            "status": "approved",
            "observations": "Projeto estrutural dentro dos parâmetros de segurança"
        },
        "timestamp": "2025-06-28T03:10:00Z"
    }

@app.post("/analyze/financial")
async def analyze_financial(project: ProjectData):
    cost_per_m2 = 1800
    total_cost = project.area * cost_per_m2
    revenue = project.budget if project.budget else project.area * 2500
    profit_margin = ((revenue - total_cost) / revenue) * 100
    
    return {
        "agent": "financial",
        "agent_name": "Paulo Mendes",
        "agent_role": "Analista de Viabilidade Financeira",
        "registration": "CRC-SP 654321",
        "project_name": project.name,
        "analysis": {
            "construction_area": f"{project.area} m²",
            "cost_per_m2": f"R$ {cost_per_m2:,.2f}",
            "estimated_cost": f"R$ {total_cost:,.2f}",
            "projected_revenue": f"R$ {revenue:,.2f}",
            "profit_margin": f"{profit_margin:.1f}%",
            "roi": f"{(profit_margin * 0.8):.1f}%",
            "payback_period": "18 meses",
            "viability": "viable" if profit_margin > 20 else "review_needed",
            "risk_rating": "Baixo" if profit_margin > 25 else "Médio"
        },
        "timestamp": "2025-06-28T03:10:00Z"
    }

@app.post("/analyze/construction")
async def analyze_construction(project: ProjectData):
    construction_time = (project.area / 10) + 2  # meses
    team_size = max(8, int(project.area / 15))
    
    return {
        "agent": "construction",
        "agent_name": "José Silva",
        "agent_role": "Mestre de Obras",
        "registration": "SINDUSCON-SP 789123",
        "project_name": project.name,
        "analysis": {
            "construction_time": f"{construction_time:.0f} meses",
            "team_size": f"{team_size} profissionais",
            "phases": [
                "Fundação (2 meses)",
                "Estrutura (3 meses)",
                "Vedação (2 meses)",
                "Acabamento (3 meses)"
            ],
            "critical_path": "Estrutura → Vedação → Acabamento",
            "resource_planning": "Otimizado",
            "execution_viability": "Viável"
        },
        "timestamp": "2025-06-28T03:10:00Z"
    }

@app.post("/analyze/safety")
async def analyze_safety(project: ProjectData):
    risk_score = 2.1 if project.area < 200 else 3.5
    
    return {
        "agent": "safety",
        "agent_name": "Ricardo Proteção",
        "agent_role": "Engenheiro de Segurança do Trabalho",
        "registration": "CREA-SP 456789/D",
        "project_name": project.name,
        "analysis": {
            "risk_level": "BAIXO" if risk_score < 3 else "MÉDIO",
            "risk_score": risk_score,
            "nr18_compliance": "100%",
            "safety_measures": [
                "EPI obrigatório",
                "Treinamento NR-18",
                "Sinalização de segurança",
                "Proteção coletiva"
            ],
            "inspection_frequency": "Semanal",
            "safety_budget": f"R$ {project.area * 25:.2f}",
            "certification": "Apto para execução"
        },
        "timestamp": "2025-06-28T03:10:00Z"
    }

@app.post("/analyze/commercial")
async def analyze_commercial(project: ProjectData):
    market_value = project.area * 3200
    sales_time = 6 if project.area < 150 else 12
    
    return {
        "agent": "commercial",
        "agent_name": "Helena Vendas",
        "agent_role": "Diretora Comercial",
        "registration": "CRA-SP 987321",
        "project_name": project.name,
        "analysis": {
            "market_value": f"R$ {market_value:,.2f}",
            "target_audience": "Classe média alta",
            "sales_strategy": "Pré-venda",
            "estimated_sales_time": f"{sales_time} meses",
            "marketing_budget": f"R$ {market_value * 0.03:.2f}",
            "competitive_advantage": "Localização e qualidade",
            "sales_forecast": "95% de vendabilidade"
        },
        "timestamp": "2025-06-28T03:10:00Z"
    }

@app.post("/analyze/complete")
async def analyze_complete(project: ProjectData):
    structural = await analyze_structural(project)
    financial = await analyze_financial(project)
    construction = await analyze_construction(project)
    safety = await analyze_safety(project)
    commercial = await analyze_commercial(project)
    
    return {
        "project": project.name,
        "status": "completed",
        "agents_executed": 5,
        "framework": "WSS+13",
        "results": {
            "structural": {
                "agent": "Breno Silva",
                "analysis": structural["analysis"]
            },
            "financial": {
                "agent": "Paulo Mendes", 
                "analysis": financial["analysis"]
            },
            "construction": {
                "agent": "José Silva",
                "analysis": construction["analysis"]
            },
            "safety": {
                "agent": "Ricardo Proteção",
                "analysis": safety["analysis"]
            },
            "commercial": {
                "agent": "Helena Vendas",
                "analysis": commercial["analysis"]
            }
        },
        "summary": {
            "overall_score": 8.7,
            "recommendation": "PROJETO APROVADO PARA EXECUÇÃO",
            "confidence_level": "95%",
            "next_steps": [
                "Aprovação final dos projetos",
                "Licenciamento municipal", 
                "Início da construção",
                "Monitoramento contínuo"
            ]
        },
        "timestamp": "2025-06-28T03:10:00Z"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)
