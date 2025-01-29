import pytest
from app import app

@pytest.fixture
def client():
    return app.test_client()

def test_hello_route(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello, CI/CD World!" in response.data
