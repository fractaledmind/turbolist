// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

navigation.addEventListener('navigate', (event) => {
  const toUrl = new URL(event.destination.url);
  const fromPath = location.pathname;

  console.log(toUrl.pathname, fromPath)
  document.documentElement.dataset.fromPath = fromPath;
  document.documentElement.dataset.toPath = toUrl.pathname;
});

import "trix"
import "@rails/actiontext"
