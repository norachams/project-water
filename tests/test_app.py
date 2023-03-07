import unittest
import os
os.environ['TESTING'] = 'true'

from app import app

class AppTestCase(unittest.TestCase):
    def setUp(self):
        self.client = app.test_client()
    
    def test_home(self):
        response = self.client.get("/")
        assert response.status_code == 200
        html = response.get_data(as_text=True)
        assert "<title> MLH Fellow </title>" in html
        # TODO Add more tests relating to the home page
        # Test that the home page has links to other pages
        assert '<a href="/timeline">Timeline</a>' in html
        assert '<a href="/about">About</a>' in html

    def test_timeline(self):
        response = self.client.get("/api/timeline_post")
        assert response.status_code == 200
        assert response.is_json
        json = response.get_json()
        assert "timeline_posts" in json
        assert len(json["timeine_posts"]) == 0
        # TODO Add more tests relating to the /api/timeline_post GET and POST apis

        for post in json["timeline_posts"]:
            assert "name" in post
            assert "email" in post
            assert "content" in post
            assert post["name"] != ""
            assert post["email"] != ""
            assert post["content"] != ""

        # TODO Add more tests relating to the timeline page

        # Test creating a new post
        response = self.client.post("/api/timeline_post", data=json.dumps({"name": "Test User", "email": "test@example.com", "content": "Test content"}), content_type="application/json")
        assert response.status_code == 201
        assert response.is_json
        json = response.get_json()
        assert "id" in json
        assert json["id"] > 0
        assert json["name"] == "Test User"
        assert json["email"] == "test@example.com"
        assert json["content"] == "Test content"