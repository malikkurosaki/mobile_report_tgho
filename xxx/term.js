const prompts = require('prompts');
const fs = require('fs');
const lists = JSON.parse(fs.readFileSync('lists.json', 'utf8'));

(async () => {
    const response = await prompts({
        type: 'select',
        name: 'value',
        message: 'pilih list',
        choices: lists,
        initial: 0
    });

    try {
        
        fs.writeFileSync('tmp', `${response.value}`);
    } catch (error) {
        fs.writeFileSync('tmp', "null");
    }
})();