module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/container-queries'),
    require("@tailwindcss/forms")({
      strategy: 'class', // only generate classes
    }),
  ],
}
