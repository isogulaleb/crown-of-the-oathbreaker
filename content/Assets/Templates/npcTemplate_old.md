---
type: NPC
location:
tags:
  - being/npc
---
<%*
/*
const targetFolder = "World/Being/NPC";
let title = tp.file.title;

// 1. Ha a fájl neve "Untitled" (tehát most jött létre üresen), kérjen nevet
if (title.startsWith("Untitled")) {
    const newName = await tp.system.prompt("NPC neve", "");
    if (newName) {
        title = newName;
        // Azonnal átnevezzük és a jó mappába mozgatjuk
        await tp.file.rename(`${title}`);
        await tp.file.move(`${targetFolder}/${title}`);
    }
} else {
    // 2. Ha már van neve (mert az Alt-L szkript hozta létre), csak mozgassa a helyére
    if (tp.file.folder() !== targetFolder) {
        await tp.file.move(`${targetFolder}/${title}`);
    }
}
*/
-%># [[<% tp.file.title %>]]
