# Start from the Rocker R base image with a specific R version
FROM rocker/r-base:4.3.1

# Set both P3M and CRAN to allow binary installation and a fallback
RUN echo 'options(repos = c(P3M = "https://packagemanager.posit.co/cran/__linux__/jammy/latest", CRAN = "https://cloud.r-project.org"))' >>"${R_HOME}/etc/Rprofile.site"

# Install system dependencies for renv if needed
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for your app
RUN mkdir /project

# Set the working directory to the app directory
WORKDIR /project

# Copy only the necessary project files
COPY renv.lock ./

# Install renv and restore packages
RUN R -e "install.packages('renv')"
RUN R -e "renv::consent(provided = TRUE)" # Automatically agree to renv prompts
RUN R -e "renv::restore()"

# Expose a port if your app includes a Shiny app or other web service
EXPOSE 3838

# Run an R command or script when the container starts
CMD ["R"]