"""
ASGI config for beacon_awards project.
"""
import os
from django.core.asgi import get_asgi_application

# CHANGE THIS LINE
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'beacon_awards.settings')

application = get_asgi_application()