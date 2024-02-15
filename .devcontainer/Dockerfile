# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2
FROM mcr.microsoft.com/devcontainers/ruby:1-$RUBY_VERSION-bookworm

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      libvips \
      #  For video thumbnails
      ffmpeg \
      # For pdf thumbnails. If you want to use mupdf instead of poppler,
      # you can install the following packages instead:
      # mupdf mupdf-tools
      poppler-utils
