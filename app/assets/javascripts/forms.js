document.addEventListener('turbolinks:load', function() {
  document
    .querySelectorAll("form[data-remote]")
    .forEach(function remoteForm(formElement) {
      formElement.onsubmit = function(e) {
        fetch(
          formElement.action,
          {
            credentials: "same-origin",
            headers: {
              "Accept": "text/html",
              "cache-control": "no-cache",
              "pragma": "no-cache",
              "X-Requested-With": "XMLHttpRequest"
            },
            method: "POST",
            body: new FormData(formElement)
          }
        )
          .then(
            function(response) {
              if(response.ok) {
                return response.text();
              } else {
                throw "Received a response with status " + response.status;
              }
            }
          )
          .then(
            function(body) {
              if (/Turbolinks/.test(body)) {  // FIXME: Play nicely with turbolinks for now. It's not an ideal solution, but a more robust one would take much more time.
                eval(body);
              } else {
                var parent = formElement.parentNode;
                var node = document.createElement("div");
                var form = document.createElement("form");
                node.appendChild(form);
                form.outerHTML = body;
                remoteForm(node.children[0]);
                parent.replaceChild(node.children[0], formElement);
              }
            }
          )
          .catch(function(error) {
            console.log(error);
          });

        e.preventDefault();
      }
    })
});
