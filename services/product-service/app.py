import os
from flask import Flask
from flask_cors import CORS
from dotenv import load_dotenv
from prometheus_flask_exporter import PrometheusMetrics
from routes.products import products_bp

load_dotenv()
app = Flask(__name__)
CORS(app)
metrics = PrometheusMetrics(app)
app.register_blueprint(products_bp, url_prefix='/api/products')

@app.route('/health')
def health(): return {'status': 'ok', 'service': 'product-service'}
@app.route('/ready')
def ready(): return {'status': 'ready'}

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5001))
    app.run(host='0.0.0.0', port=port, debug=os.getenv('FLASK_ENV') == 'development')
