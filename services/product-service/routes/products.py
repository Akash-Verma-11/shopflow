from flask import Blueprint, request, jsonify
from db.connection import get_connection
products_bp = Blueprint('products', __name__)

@products_bp.route('/', methods=['GET'])
def get_products():
    try:
        conn = get_connection(); cur = conn.cursor()
        cur.execute('SELECT id, name, price, stock FROM products ORDER BY created_at DESC')
        products = cur.fetchall(); cur.close(); conn.close()
        return jsonify([dict(p) for p in products])
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@products_bp.route('/<int:product_id>', methods=['GET'])
def get_product(product_id):
    try:
        conn = get_connection(); cur = conn.cursor()
        cur.execute('SELECT * FROM products WHERE id = %s', (product_id,))
        product = cur.fetchone(); cur.close(); conn.close()
        if not product: return jsonify({'error': 'Product not found'}), 404
        return jsonify(dict(product))
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@products_bp.route('/', methods=['POST'])
def create_product():
    data = request.get_json()
    name = data.get('name'); price = data.get('price'); stock = data.get('stock', 0)
    if not name or price is None: return jsonify({'error': 'name and price required'}), 400
    try:
        conn = get_connection(); cur = conn.cursor()
        cur.execute('INSERT INTO products (name, price, stock) VALUES (%s, %s, %s) RETURNING id, name, price, stock', (name, price, stock))
        product = cur.fetchone(); conn.commit(); cur.close(); conn.close()
        return jsonify(dict(product)), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
