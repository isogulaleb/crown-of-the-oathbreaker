<%*
const types = [
    { name: "NPC", folder: "World/Being/NPC", template: "npcTemplate" },
    { name: "Historical Person", folder: "World/Being/Historical", template: "historicalTemplate" },
    { name: "Location", folder: "World/Location", template: "locationTemplate" },    
    { name: "History", folder: "World/Lore/History", template: "historyTemplate" },
    { name: "Event", folder: "World/Event", template: "eventTemplate" },
    { name: "Deity", folder: "World/Being/Deity", template: "deityTemplate" },
    { name: "Item", folder: "World/Loot", template: "itemTemplate" },
    { name: "Group", folder: "World/Group", template: "groupTemplate" },
    { name: "Monster", folder: "World/Monster", template: "monsterTemplate" },
    { name: "Session Note", folder: "Session notes", template: "sessionTemplate" }
];

// 1. Cím bekérése
let title = tp.file.selection();
if (!title) title = await tp.system.prompt("Új jegyzet címe");
if (!title) return;

// Tiltott karakterek szűrése
title = title.replace(/[\\/:*?"<>|]/g, "");

// 2. Típus választása
const choice = await tp.system.suggester(types.map(template => template.name), types);
if (!choice) return;

// 3. Sablon keresése
const templateFile = tp.file.find_tfile(choice.template);
if (!templateFile) {
    new Notice(`HIBA: Sablon nem található: ${choice.template}`);
    return;
}

// 4. Útvonalak összeállítása
const folderPath = choice.folder;
const filePath = `${folderPath}/${title}.md`;

try {
    // Ellenőrizzük, létezik-e a mappa
    if (!(await app.vault.adapter.exists(folderPath))) {
        await app.vault.createFolder(folderPath);
    }

    // Ellenőrizzük, létezik-e a fájl
    if (await app.vault.adapter.exists(filePath)) {
        new Notice("A fájl már létezik!");
    } else {
        // Sablon tartalmának beolvasása
        const templateContent = await app.vault.read(templateFile);
        
        // Fájl létrehozása az Obsidian alap API-val (ez nem fog elszállni)
        await app.vault.create(filePath, templateContent);
        new Notice(`Sikeresen létrehozva: ${title}`);
    }

    // 5. Link beszúrása az aktuális szerkesztőbe
    // A tR += parancs helyett a Templater saját belső változóját használjuk a végén
    _res = `[[${title}]]`;
} catch (e) {
    console.error("Részletes hiba:", e);
    new Notice("Váratlan hiba történt a fájl művelet közben.");
}
%><%- _res %>