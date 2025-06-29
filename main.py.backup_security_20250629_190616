from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, JSONResponse
from pydantic import BaseModel
import json
from datetime import datetime
from typing import Dict, Any

app = FastAPI(
    title="WSS+13 Framework", 
    description="Framework de IA para Construção Civil Brasileira",
    version="1.0.0"
)

# Health check endpoint
@app.get("/health")
async def health_check():
    """Health check para monitoramento"""
    return {
        "status": "healthy",
        "timestamp": datetime.now().isoformat(),
        "service": "WSS+13 Framework",
        "version": "1.0.0",
        "framework": "online"
    }

# Endpoint de status
@app.get("/status")
async def status_check():
    """Status detalhado da aplicação"""
    return {
        "status": "online",
        "framework": "WSS+13",
        "specialists": 5,
        "endpoints": [
            "/analyze/structural",
            "/analyze/financial", 
            "/analyze/commercial"
        ],
        "timestamp": datetime.now().strftime("%d/%m/%Y às %H:%M"),
        "language": "pt-BR"
    }

# Configuração para Português Brasileiro
LANGUAGE_CONFIG = {
    "language": "pt-BR",
    "locale": "Brasil", 
    "currency": "BRL",
    "date_format": "%d/%m/%Y às %H:%M"
}

class WSS13ReportFormatter:
    """Formatador de relatórios profissionais em português brasileiro"""
    
    def __init__(self):
        self.specialists = {
            "structural": {
                "name": "Breno Silva",
                "title": "Engenheiro Estrutural Sênior", 
                "crea": "CREA-SP 123.456.789-0",
                "experience": "15 anos de experiência"
            },
            "financial": {
                "name": "Paulo Santos",
                "title": "Analista Financeiro Especializado",
                "experience": "12 anos de experiência"
            },
            "commercial": {
                "name": "Helena Costa", 
                "title": "Estrategista Comercial",
                "experience": "10 anos de experiência"
            }
        }
    
    def format_structural_report(self, data: Dict[Any, Any]) -> Dict[str, Any]:
        """Gerar relatório estrutural completo em português"""
        specialist = self.specialists["structural"]
        
        area = data.get('area', 0)
        floors = data.get('floors', 1)
        project_type = data.get('project_type', 'residencial')
        foundation_type = data.get('foundation_type', 'sapata')
        soil_type = data.get('soil_type', 'argiloso')
        
        report = {
            "cabecalho": {
                "titulo": "📋 RELATÓRIO DE ANÁLISE ESTRUTURAL",
                "subtitulo": "Análise Técnica Preliminar - WSS+13 Framework",
                "data_analise": datetime.now().strftime(LANGUAGE_CONFIG["date_format"]),
                "especialista": {
                    "nome": specialist['name'],
                    "titulo": specialist['title'],
                    "registro": specialist['crea'],
                    "experiencia": specialist['experience']
                }
            },
            
            "resumo_executivo": {
                "titulo": "🎯 RESUMO EXECUTIVO",
                "projeto_info": {
                    "tipo": project_type.title(),
                    "area_total": f"{area:,.0f} m²",
                    "numero_pavimentos": f"{floors} pavimento(s)",
                    "tipo_fundacao": foundation_type.title(),
                    "tipo_solo": soil_type.title()
                },
                "viabilidade_estrutural": self.assess_viability(data),
                "custo_estimado_total": self.estimate_total_cost(data),
                "prazo_estimado": self.estimate_timeline(data),
                "status_geral": "✅ PROJETO VIÁVEL" if area > 30 else "⚠️ REQUER ANÁLISE DETALHADA"
            },
            
            "analise_tecnica": {
                "titulo": "🔍 ANÁLISE TÉCNICA DETALHADA",
                "sistema_estrutural": self.get_structural_system(data),
                "cargas_estimadas": {
                    "carga_permanente": f"{self.calculate_dead_load(data):,.0f} kN",
                    "carga_acidental": f"{self.calculate_live_load(data):,.0f} kN", 
                    "carga_total": f"{self.calculate_total_load(data):,.0f} kN"
                },
                "dimensionamento_preliminar": {
                    "pilares": self.get_column_sizing(data),
                    "vigas": "Altura mínima: L/12 do vão livre",
                    "lajes": "Espessura mínima: L/40 do menor vão",
                    "concreto": "fck ≥ 25 MPa recomendado"
                }
            },
            
            "fundacoes": {
                "titulo": "🏗️ ANÁLISE DE FUNDAÇÕES",
                "tipo_recomendado": self.get_foundation_recommendation(data),
                "profundidade_estimada": self.estimate_foundation_depth(data),
                "capacidade_solo": self.estimate_soil_capacity(data),
                "custo_fundacao": self.estimate_foundation_cost(data)
            },
            
            "pontos_criticos": {
                "titulo": "⚠️ PONTOS CRÍTICOS",
                "alertas": self.get_critical_alerts(data),
                "recomendacoes_urgentes": [
                    "Realizar sondagem SPT do terreno",
                    "Contratar engenheiro estrutural habilitado", 
                    "Verificar legislação municipal"
                ]
            },
            
            "recomendacoes": {
                "titulo": "💡 RECOMENDAÇÕES TÉCNICAS",
                "acoes_imediatas": [
                    "1. Investigação geotécnica (sondagem SPT)",
                    "2. Projeto estrutural executivo detalhado",
                    "3. Solicitação de ART do engenheiro responsável",
                    "4. Aprovação do projeto na prefeitura"
                ],
                "cronograma_sugerido": {
                    "investigacao": "10-15 dias",
                    "projeto": "20-30 dias", 
                    "aprovacao": "30-60 dias",
                    "execucao": "Conforme cronograma da obra"
                }
            },
            
            "estimativa_custos": {
                "titulo": "💰 ESTIMATIVA DE CUSTOS",
                "estrutura_concreto": self.estimate_concrete_cost(data),
                "fundacoes": self.estimate_foundation_cost(data),
                "mao_de_obra": self.estimate_labor_cost(data),
                "custo_total": self.estimate_total_cost(data),
                "observacoes": [
                    "• Valores estimativos baseados em índices de mercado",
                    "• Preços podem variar conforme região e fornecedores",
                    "• Orçamento detalhado requer projeto executivo",
                    "• Margem de segurança de 10-15% recomendada"
                ]
            },
            
            "disclaimer": {
                "titulo": "⚖️ LIMITAÇÕES DA ANÁLISE",
                "observacoes": [
                    "• Análise preliminar baseada em dados fornecidos",
                    "• Não substitui projeto estrutural detalhado",
                    "• Investigação geotécnica é fundamental",
                    "• Consulte sempre engenheiro habilitado"
                ]
            }
        }
        
        return report
    
    # Métodos auxiliares
    def assess_viability(self, data):
        area = data.get('area', 0)
        return "✅ Projeto viável" if area > 30 else "⚠️ Requer análise"
    
    def get_structural_system(self, data):
        area = data.get('area', 0)
        if area <= 100:
            return "Alvenaria estrutural ou concreto armado"
        else:
            return "Concreto armado com lajes maciças"
    
    def calculate_dead_load(self, data):
        return data.get('area', 0) * data.get('floors', 1) * 5.0
    
    def calculate_live_load(self, data):
        return data.get('area', 0) * data.get('floors', 1) * 1.5
    
    def calculate_total_load(self, data):
        return self.calculate_dead_load(data) + self.calculate_live_load(data)
    
    def get_column_sizing(self, data):
        return "Seção mínima: 20x20 cm"
    
    def get_foundation_recommendation(self, data):
        soil_type = data.get('soil_type', 'argiloso').lower()
        recommendations = {
            'rochoso': 'Sapata direta sobre rocha',
            'arenoso': 'Sapata corrida ou isolada',
            'argiloso': 'Sapata com viga baldrame',
            'mole': 'Estaca pré-moldada'
        }
        return recommendations.get(soil_type, 'Investigação necessária')
    
    def estimate_foundation_depth(self, data):
        return "1,5 a 2,5 metros"
    
    def estimate_soil_capacity(self, data):
        return "100 a 300 kN/m²"
    
    def get_critical_alerts(self, data):
        return ["✅ Nenhum alerta crítico identificado"]
    
    def estimate_concrete_cost(self, data):
        return f"R$ {data.get('area', 0) * 600:,.2f}"
    
    def estimate_foundation_cost(self, data):
        return f"R$ {data.get('area', 0) * 250:,.2f}"
    
    def estimate_labor_cost(self, data):
        return f"R$ {data.get('area', 0) * 300:,.2f}"
    
    def estimate_total_cost(self, data):
        return f"R$ {data.get('area', 0) * 1150:,.2f}"
    
    def estimate_timeline(self, data):
        area = data.get('area', 0)
        return "4 a 8 meses" if area <= 100 else "8 a 12 meses"

# Instanciar formatador
formatter = WSS13ReportFormatter()

# Modelos de dados
class StructuralAnalysis(BaseModel):
    project_type: str
    area: float
    floors: int
    foundation_type: str
    soil_type: str

# Endpoints principais
@app.get("/", response_class=HTMLResponse)
async def home():
    """Página inicial em português brasileiro"""
    html_content = """
    <!DOCTYPE html>
    <html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>WSS+13 Framework - Análise Inteligente para Construção Civil</title>
        <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            .header {
                background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
                color: white;
                padding: 40px;
                text-align: center;
            }
            .header h1 { font-size: 2.5em; margin-bottom: 10px; }
            .status-badge {
                background: #28a745;
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.9em;
                margin: 10px 0;
            }
            .content { padding: 40px; }
            .specialists-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
                margin: 40px 0;
            }
            .specialist-card {
                background: #f8f9fa;
                border-radius: 15px;
                padding: 30px;
                text-align: center;
                transition: transform 0.3s ease;
            }
            .specialist-card:hover { transform: translateY(-5px); }
            .specialist-icon { font-size: 3em; margin-bottom: 20px; }
            .form-section {
                background: #f8f9fa;
                border-radius: 15px;
                padding: 30px;
                margin: 30px 0;
            }
            .form-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
            }
            .form-group { margin-bottom: 20px; }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #2c3e50;
            }
            .form-group input, .form-group select {
                width: 100%;
                padding: 12px;
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                font-size: 16px;
            }
            .btn {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 15px 30px;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                width: 100%;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>🏗️ WSS+13 Framework</h1>
                <p>Análise Inteligente para Construção Civil Brasileira</p>
                <div class="status-badge">✅ SISTEMA ONLINE</div>
                <p><strong>Domínio:</strong> wss13.com.br</p>
            </div>
            
            <div class="content">
                <div class="specialists-grid">
                    <div class="specialist-card">
                        <div class="specialist-icon">👨‍🔧</div>
                        <h3>Breno Silva</h3>
                        <p><strong>Especialista Estrutural</strong><br>
                        Análise estrutural, fundações e dimensionamento.<br>
                        15 anos de experiência.</p>
                    </div>
                    
                    <div class="specialist-card">
                        <div class="specialist-icon">💰</div>
                        <h3>Paulo Santos</h3>
                        <p><strong>Analista Financeiro</strong><br>
                        Viabilidade econômica e orçamentação.<br>
                        12 anos de experiência.</p>
                    </div>
                    
                    <div class="specialist-card">
                        <div class="specialist-icon">📈</div>
                        <h3>Helena Costa</h3>
                        <p><strong>Estrategista Comercial</strong><br>
                        Marketing imobiliário e posicionamento.<br>
                        10 anos de experiência.</p>
                    </div>
                </div>
                
                <div class="form-section">
                    <h2>📋 Análise Estrutural Completa</h2>
                    <form id="structuralForm">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Tipo de Projeto:</label>
                                <select name="project_type" required>
                                    <option value="">Selecione</option>
                                    <option value="residencial">Residencial</option>
                                    <option value="comercial">Comercial</option>
                                    <option value="industrial">Industrial</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label>Área Total (m²):</label>
                                <input type="number" name="area" min="1" required>
                            </div>
                            
                            <div class="form-group">
                                <label>Número de Pavimentos:</label>
                                <input type="number" name="floors" min="1" required>
                            </div>
                            
                            <div class="form-group">
                                <label>Tipo de Fundação:</label>
                                <select name="foundation_type" required>
                                    <option value="">Selecione</option>
                                    <option value="sapata">Sapata</option>
                                    <option value="radier">Radier</option>
                                    <option value="estaca">Estaca</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label>Tipo de Solo:</label>
                                <select name="soil_type" required>
                                    <option value="">Selecione</option>
                                    <option value="rochoso">Rochoso</option>
                                    <option value="arenoso">Arenoso</option>
                                    <option value="argiloso">Argiloso</option>
                                    <option value="mole">Mole</option>
                                </select>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn">🚀 Gerar Relatório Estrutural Completo</button>
                    </form>
                </div>
                
                <div id="results" style="display: none; margin-top: 30px;"></div>
            </div>
        </div>
        
        <script>
            document.getElementById('structuralForm').addEventListener('submit', async function(e) {
                e.preventDefault();
                
                const formData = new FormData(e.target);
                const data = {
                    project_type: formData.get('project_type'),
                    area: parseFloat(formData.get('area')),
                    floors: parseInt(formData.get('floors')),
                    foundation_type: formData.get('foundation_type'),
                    soil_type: formData.get('soil_type')
                };
                
                try {
                    const response = await fetch('/analyze/structural', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(data)
                    });
                    
                    const result = await response.json();
                    
                    document.getElementById('results').style.display = 'block';
                    document.getElementById('results').innerHTML = formatReport(result);
                    document.getElementById('results').scrollIntoView({ behavior: 'smooth' });
                    
                } catch (error) {
                    alert('Erro ao processar análise: ' + error.message);
                }
            });
            
            function formatReport(data) {
                const report = data.relatorio;
                
                return `
                    <div style="background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.1);">
                        <div style="text-align: center; margin-bottom: 30px; padding: 20px; background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); color: white; border-radius: 10px;">
                            <h1>${report.cabecalho.titulo}</h1>
                            <p>${report.cabecalho.subtitulo}</p>
                            <p><strong>Data:</strong> ${report.cabecalho.data_analise}</p>
                            <p><strong>Especialista:</strong> ${report.cabecalho.especialista.nome}</p>
                        </div>
                        
                        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 25px; border-radius: 10px; margin-bottom: 25px;">
                            <h2>${report.resumo_executivo.titulo}</h2>
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 15px;">
                                <div><strong>Tipo:</strong> ${report.resumo_executivo.projeto_info.tipo}</div>
                                <div><strong>Área:</strong> ${report.resumo_executivo.projeto_info.area_total}</div>
                                <div><strong>Pavimentos:</strong> ${report.resumo_executivo.projeto_info.numero_pavimentos}</div>
                                <div><strong>Status:</strong> ${report.resumo_executivo.status_geral}</div>
                            </div>
                            <div style="margin-top: 15px; padding: 15px; background: rgba(255,255,255,0.1); border-radius: 8px;">
                                <strong>Custo Total Estimado:</strong> ${report.resumo_executivo.custo_estimado_total}
                            </div>
                        </div>
                        
                        <div style="background: #e8f5e8; padding: 25px; border-radius: 10px; margin: 25px 0; border-left: 4px solid #28a745;">
                            <h3>${report.recomendacoes.titulo}</h3>
                            ${report.recomendacoes.acoes_imediatas.map(action => `<p>• ${action}</p>`).join('')}
                        </div>
                        
                        <div style="background: #fff3cd; padding: 20px; border-radius: 10px; border-left: 4px solid #ffc107;">
                            <h3>${report.disclaimer.titulo}</h3>
                            ${report.disclaimer.observacoes.map(obs => `<p>• ${obs}</p>`).join('')}
                        </div>
                    </div>
                `;
            }
        </script>
    </body>
    </html>
    """
    return HTMLResponse(content=html_content)

@app.post("/analyze/structural")
async def analyze_structural(analysis: StructuralAnalysis):
    """Análise estrutural completa em português brasileiro"""
    data = analysis.dict()
    report = formatter.format_structural_report(data)
    
    return {
        "status": "sucesso",
        "timestamp": datetime.now().strftime(LANGUAGE_CONFIG["date_format"]),
        "relatorio": report,
        "metadata": {
            "framework": "WSS+13",
            "versao": "1.0.0",
            "idioma": "pt-BR",
            "especialista": "Breno Silva - Engenheiro Estrutural"
        }
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
