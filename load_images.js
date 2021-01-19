const fs = require('fs');
const axios = require('axios');
const url = require("url");
const path = require("path");

fetchImages = (list) => {
  const BASE_PATH = path.join(__dirname, '')
  const requests = list.map((itemUrl, idx) => new Promise((resolve, reject) => {
    axios.get(itemUrl)
      .then((response) => {

        const parsed = url.parse(itemUrl);
        // console.debug('API response', imagesUrls[stageIdx], response.data);
        const fileName = path.basename(parsed.pathname);
        fs.writeFile(fileName, response.data, () => {
          console.log('wrote the file', fileName);
        })
        resolve(response);
      })
      .catch((error) => {
        console.debug('API error', itemUrl, error);
        // TODO: handle the reject case properly
        // reject(error);
      });
  }));


  Promise.all(requests)
    .then(response => console.debug('Promise all response', response))
    .catch(error => console.debug('Promise all error', error));
};

// fetchImages(images);