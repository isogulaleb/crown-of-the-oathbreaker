<%*
const types = [
    { name: "NPC", folder: "World/Being/NPC", template: "npcTemplate" },
    { name: "Location", folder: "World/Location", template: "locationTemplate" },    
    { name: "History", folder: "World/Lore/History", template: "historyTemplate" },
    { name: "Event", folder: "World/Event", template: "eventTemplate" },
    { name: "Deity", folder: "World/Being/Deity", template: "deityTemplate" },
    { name: "Session Note", folder: "Session notes", template: "sessionTemplate" },
    { name: "Üres", folder: "", template: null }
];

const currentFile = tp.config.target_file;
if (!currentFile) return;

const title = await tp.system.prompt("Cím:", currentFile.basename);
const choice = await tp.system.suggester(types.map(t => t.name), types);

if (choice) {
    let content = "";
    if (choice.template) {
        const tFile = tp.file.find_tfile(choice.template);
        if (tFile) {
            const raw = await app.vault.read(tFile);
            content = raw.split("<% tp.file.title %>").join(title);
        }
    }

    await app.vault.modify(currentFile, content);

    if (choice.folder) {
        if (!(await app.vault.adapter.exists(choice.folder))) {
            await app.vault.createFolder(choice.folder);
        }
        await app.fileManager.renameFile(currentFile, choice.folder + "/" + title + ".md");
    } else {
        await app.fileManager.renameFile(currentFile, title + ".md");
    }
}
%>
