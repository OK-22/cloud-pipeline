from app import app


def test_health_returns_ok():
    client = app.test_client()
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "ok"}


def test_index_has_message_and_version():
    client = app.test_client()
    data = client.get("/").get_json()
    assert data["message"] == "Hello from the cloud pipeline"
    assert "version" in data and "host" in data
