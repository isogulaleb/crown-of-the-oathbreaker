<%*
const types = [
    {n: "NPC", f: "World/Being/NPC", t: "npcTemplate"},
    {n: "Location", f: "World/Location", t: "locationTemplate"},
    {n: "Deity", f: "World/Being/Deity", t: "deityTemplate"},
    {n: "Historical Person", f: "World/Being/Historical", t: "historicalTemplate"},
    {n: "Item", f: "World/Loot", t: "itemTemplate"},
    {n: "Group", f: "World/Group", t: "groupTemplate"},
    {n: "Group", f: "World/Monster", t: "monsterTemplate"},
    {n: "Empty", f: "", t: null}
];

const cur = tp.config.target_file;

if (cur) {
    const name = await tp.system.prompt("Név:", cur.basename);
    const items = types.map(i => i.n);
    const pick = await tp.system.suggester(items, types);

    if (pick) {
        let txt = "";
        if (pick.t) {
            const tf = tp.file.find_tfile(pick.t);
            if (tf) {
                const raw = await app.vault.read(tf);
                // Széttörjük a stringet, hogy a Templater ne zavarodjon össze
                const placeholder = "<" + "% tp.file.title %" + ">";
                txt = raw.split(placeholder).join(name);
            }
        }

        await app.vault.modify(cur, txt);
        
        const path = pick.f ? pick.f + "/" + name + ".md" : name + ".md";
        
        setTimeout(async () => {
            await app.fileManager.renameFile(cur, path);
        }, 300);
    }
}
%>
