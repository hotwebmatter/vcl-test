vcl 4.1;

# X-Custom-Origin header test
if (!req.http.X-Custom-Origin) {
  // Return a custom error because we don't see our header
  return(synth(417, "Expectation Failed"));
} else {
  // We see our header and become a teapot
  return(synth(418, "I'm A Teapot"));
}