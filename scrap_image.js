const {
    GOOGLE_IMG_SCRAP,
    GOOGLE_IMG_INVERSE_ENGINE_URL,
    GOOGLE_IMG_INVERSE_ENGINE_UPLOAD,
    GOOGLE_QUERY,
} = require("google-img-scrap");


const yargs = require('yargs');

// Define the command-line options
const options = yargs
    .option('m', {
        alias: 'multiple',
        describe: 'Allow multiple queries',
        type: 'boolean'
    })
    .argv;

// Access the command-line options
const multiple = options.multiple;

// Prompt the user for queries
const readline = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});

const queries = [];

// the help function
if (options.help) {
    console.log('Usage: node scrap_image.js [query] [number] [path]');
    console.log('Options:');
    console.log('  -m, --multiple  Allow multiple queries');
    console.log('  --help          Show help');
    return;
}

async function promptForQuery() {
    await readline.question('Enter a query (or "done" to finish): ', query => {
        if (query === 'done') {
            readline.close();
            processQueries();
        } else {
            queries.push(query);
            promptForQuery();
        }
    });
}

async function processQueries(number = 10, path = '.', query = '') {
    // Process the queries here
    console.log(`Queries: ${queries.join(', ')}`);
    // if number is not given, then set it to 10
    if (number == undefined) {
        number = 10;
    }

    // if path is not given, then set it to .
    if (path == undefined) {
        path = '.';
    }

    // if number is less than or equal to 0, then set it to 10
    if (number <= 0) {
        number = 10;
    }

    // if path is ., then find the path of the directory from where this script is running.
    if (path == '.') {
        const cwd = process.cwd();
        path = cwd;
        console.log(path);
    }
    if (query == '' && queries.length === 0) {
        console.log('No query given, you gotta enter something to search for');
        return;
    }
    if (queries.length > 0) {
        queries.forEach(query => {
            save_images(query, path, number);
        });
        return;
    }
    if (query != '') {
        await save_images(query, path, number);
        // exit the process after completion of the task
        process.exit();
    }
    return;
}

if (multiple) {
    promptForQuery();
} else {
    const args = process.argv.slice(2);
    const query = args[0];
    let number = args[1];
    let path = args[2];
    console.log(`Query: ${query}`);
    console.log(`Number: ${number}`);
    console.log(`Path: ${path}`);
    processQueries(number, path, query);
}

async function get_images(query, number) {
    const images = await GOOGLE_IMG_SCRAP({
        search: query,
        limit: number,
        safeSearch: true,
        query: {
            SIZE: GOOGLE_QUERY.SIZE.LARGE,
            // TYPE: GOOGLE_QUERY.TYPE.CLIPART,
            // LICENCE: GOOGLE_QUERY.LICENCE.COMMERCIAL_AND_OTHER,
            // EXTENSION: GOOGLE_QUERY.EXTENSION.JPG,
        },
    });
    final_image_ulrs = [];
    for (let i = 0; i < images.result.length; i++) {
        final_image_ulrs.push(images.result[i].url);
    }
    // console.log(final_image_ulrs)
    return final_image_ulrs;
}

// function to download the images using the url

const download = require('image-downloader');

// function to save the images on the path. 
async function save_images(query, path, number = 10) {

    // create a directory here if it doesnt exist. 
    const fs = require('fs');
    const dir = path + '/' + query;
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir);
    }

    const images = await get_images(query, number);
    // console.log(images);
    for (let i = 0; i < images.length; i++) {
        const image = images[i];
        const image_name = `${query}_${i}.jpg`;
        const image_path = dir + '/' + image_name;
        // console.log(image_path);

        const options = {
            url: image,
            dest: image_path,               // will be saved to /path/to/dest/image.jpg
        };

        await download.image(options).then(({ filename }) => {
            console.log('Saved to', filename)  // saved to /path/to/dest/image.jpg
        }
        ).catch((err) => console.error("😔"))
    }
}


return;