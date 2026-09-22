"""
WSGI config for beacon_awards project.
"""

import os

from django.core.wsgi import get_wsgi_application

# Change from 'mwasa.settings' to 'beacon_awards.settings'
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'beacon_awards.settings')

application = get_wsgi_application()