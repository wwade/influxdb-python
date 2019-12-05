# -*- coding: utf-8 -*-
"""Initialize the influxdb package."""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

from .client import InfluxDBClient
from .helper import SeriesHelper

import os

_DATAFRAME_CLIENT = "INFLUXDB_NO_DATAFRAME_CLIENT" not in os.environ
if _DATAFRAME_CLIENT:
   from .dataframe_client import DataFrameClient


__all__ = [
    'InfluxDBClient',
    'SeriesHelper',
]
if _DATAFRAME_CLIENT:
   __all__.append( 'DataFrameClient' )

__version__ = '5.0.0'
