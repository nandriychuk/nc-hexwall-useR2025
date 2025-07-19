# Hexwall North Carolina Map Script
# This script creates a hexagonal grid over the North Carolina map and arranges hex stickers 
# from the hex-stickers folder using the hexwall() function from hexwall.R

library(sf)
library(sp)
library(ggplot2)
library(purrr)
library(dplyr)

# Source the hexwall() function from hexwall.R (should be in the same directory)
if (!file.exists("hexwall.R")) stop("hexwall.R script not found in working directory.")
source("hexwall.R")

# Load North Carolina map data
demo(nc, ask = FALSE, echo = FALSE)
nc_sf <- st_as_sf(nc)

# Create hexagonal sample points (adjust cellsize for density)
hex_points <- sp::spsample(as(nc_sf, "Spatial"), type = "hexagonal", cellsize = 0.2)

# Convert points to hexagonal polygons
hex_polys <- sp::HexPoints2SpatialPolygons(hex_points, dx = 0.2)
hex_sf <- sf::st_as_sf(hex_polys)

# Plot the NC map with hex grid overlay
p <- ggplot() +
  geom_sf(data = nc_sf, fill = "white", color = "black") +
  geom_sf(data = hex_sf, fill = NA, color = "blue") +
  theme_minimal()
print(p)

# Arrange hex stickers from hex-stickers folder using hexwall()
# Adjust sticker_width as needed for your output

# Run hexwall to create the feature wall
hexwall(
  path = "hex-stickers",
  sticker_width = 200,
  coords = hex_points@coords,
  # sort_mode = "colour"
)
