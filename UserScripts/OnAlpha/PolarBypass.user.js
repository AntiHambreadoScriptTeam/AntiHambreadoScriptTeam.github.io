// Discord Server : https://discord.gg/rTGF5xhe3h
// Página Web : https://antihambreadoscriptteam.github.io/

// ==UserScript==
// @name         Polar Patcher - AHST
// @namespace    https://antihambreadoscriptteam.github.io/
// @version      1.6
// @description  
// @author       TheRealBanHammer
// @license      MIT
// @match        https://bombhacker.pro/*
// @match        https://*.bombhacker.pro/*
// @match        https://lootdest.org/*
// @match        https://*.lootdest.org/*
// @match        https://loot-link.com/*
// @match        https://*.loot-link.com/*
// @match        https://loot-links.com/*
// @match        https://*.loot-links.com/*
// @match        https://links.lootlabs.gg/*
// @match        https://*.lootlabs.gg/*
// @match        https://ultra-links.net/*
// @match        https://*.ultra-links.net/*
// @match        https://lootboost.net/*
// @match        https://*.lootboost.net/*
// @match        https://fast-links.org/*
// @match        https://*.fast-links.org/*
// @match        https://loot-reward.com/*
// @match        https://*.loot-reward.com/*
// @match        https://nerventualken.com/*
// @match        https://*.nerventualken.com/*
// @match        https://challenges.cloudflare.com/*
// @icon         https://static.wikia.nocookie.net/chickengun-fanon/images/5/51/PolarPatchet_logo%28with_copyright%29.png/revision/latest/scale-to-width/360?cb=20240119173328&path-prefix=ru
// @run-at       document-start
// @grant        unsafeWindow
// @grant        GM_cookie
// ==/UserScript==

!function () {
    "use strict";

    const Window = "undefined" != typeof unsafeWindow ? unsafeWindow : window;
    if (Window.self !== Window.top) return;

    const Document = Window.document;
    const Hostname = Window.location.hostname.toLowerCase();
    const LootHosts = [
        "lootdest.org",
        "loot-link.com",
        "loot-links.com",
        "links.lootlabs.gg",
        "lootlabs.gg",
        "ultra-links.net",
        "lootboost.net",
        "fast-links.org",
        "loot-reward.com"
    ];
    const IsLoot = LootHosts.some(Domain => Hostname === Domain || Hostname.endsWith("." + Domain));
    const IsPolar = Hostname === "bombhacker.pro" || Hostname.endsWith(".bombhacker.pro");
    if (!IsLoot && !IsPolar) return;

    const Build = "1.6";
    const EntryKey = "polar-patcher-entry";
    const RetryKey = "polar-patcher-retry";
    const DebugState = {
        build: Build,
        page: IsLoot ? "lootlabs" : "polar",
        startedAt: new Date().toISOString(),
        phase: "inicializando",
        status: [],
        lootlabs: {},
        failure: null,
        destination: null,
        polar: {}
    };
    Window.__polarPatcherDebug = DebugState;

    const LootClient = {
        started: false,
        needsCaptcha: false,
        captchaSolved: false,
        urid: null,
        cat: null,
        tid: null,
        socket: null,
        heartbeat: null,
        destination: null,
        pending: null
    };

    const ReduceMotion = !!(Window.matchMedia && Window.matchMedia("(prefers-reduced-motion: reduce)").matches);
    const UiHost = Document.createElement("div");
    const Shadow = UiHost.attachShadow({ mode: "open" });
    let UiMounted = false;
    let LastStatus = "";
    let LeftPage = false;

    UiHost.id = "polar-patcher-ahst";
    UiHost.setAttribute("popover", "manual");
    UiHost.style.cssText = "position:fixed;inset:0;width:100vw;height:100vh;max-width:none;max-height:none;margin:0;padding:0;border:none;background:#000;z-index:2147483647;display:block;pointer-events:auto;overflow:auto;isolation:isolate";
    Shadow.innerHTML = `
        <style>
            :host{all:initial;color-scheme:dark;position:fixed!important;inset:0!important;width:100vw!important;height:100vh!important;max-width:none!important;max-height:none!important;margin:0!important;padding:0!important;border:none!important;display:block!important;background:#000!important;z-index:2147483647!important;pointer-events:auto!important;overflow:auto!important}*{box-sizing:border-box}button,input{font:inherit}
            .App{--accent:#62e8cb;position:absolute;inset:0;min-width:280px;min-height:100%;overflow:auto;background:#000;color:#f5f5f7;font-family:Inter,"SF Pro Display","Segoe UI",system-ui,sans-serif;-webkit-font-smoothing:antialiased}
            .Stage{position:relative;z-index:1;display:grid;place-items:center;min-height:100dvh;padding:max(24px,env(safe-area-inset-top)) max(18px,env(safe-area-inset-right)) max(24px,env(safe-area-inset-bottom)) max(18px,env(safe-area-inset-left))}
            .Glass{position:relative;width:min(900px,100%);transform-origin:50% 50%;will-change:transform,opacity}.Inner{position:relative}.Hero{margin:0 0 24px}.TitleLockup{display:flex;align-items:flex-end;gap:14px;min-width:0}
            h1{min-width:0;margin:0;font-size:clamp(2.35rem,7vw,5rem);font-weight:720;letter-spacing:-.055em;line-height:1}.TitleText{position:relative;display:inline-block;color:transparent;background:linear-gradient(180deg,#fff 0%,#c7c7cc 34%,#5a5a60 67%,#080808 100%);background-clip:text;-webkit-background-clip:text}
            .TitleText::after{position:absolute;inset:0;content:attr(data-title);color:transparent;background:linear-gradient(108deg,transparent 38%,rgba(255,255,255,.98) 49%,transparent 60%);background-size:230% 100%;background-position:180% 0;background-clip:text;-webkit-background-clip:text;animation:TitleReflection 5s cubic-bezier(.4,0,.2,1) infinite;pointer-events:none}
            .AhstLockup{display:flex;flex:0 0 auto;flex-direction:column;gap:4px;padding-bottom:4px}.AhstName{color:#d1d1d6;font-size:17px;font-weight:760;letter-spacing:.13em;line-height:1}.AhstLong{max-width:132px;color:rgba(235,235,245,.34);font-size:9px;font-weight:600;letter-spacing:.055em;line-height:1.25}.Subtitle{margin:10px 0 0;color:#636366;font:650 11px/1.4 "SFMono-Regular",Consolas,monospace;letter-spacing:.08em;text-transform:uppercase}
            .Console,.CaptchaPanel{overflow:hidden;border:1px solid #1c1c1e;border-radius:16px;background:#050505}.ConsoleHead{display:flex;align-items:center;gap:10px;padding:12px 15px;border-bottom:1px solid #1c1c1e;background:#080808}.TerminalDots{display:flex;align-items:center;gap:5px}.TerminalDots i{display:block;width:7px;height:7px;border-radius:50%;opacity:.78}.TerminalDots i:nth-child(1){background:#ff5f57}.TerminalDots i:nth-child(2){background:#febc2e}.TerminalDots i:nth-child(3){background:#28c840}.ConsoleTitle{color:#8e8e93;font:700 10px/1 "SFMono-Regular",Consolas,monospace;letter-spacing:.14em;text-transform:uppercase}.WaitTotal{margin-left:auto;color:var(--accent);font:800 13px/1 "SFMono-Regular",Consolas,monospace;letter-spacing:.08em}
            .ConsoleBody{height:clamp(300px,50vh,480px);overflow:auto;padding:14px 16px;scrollbar-width:thin;scrollbar-color:#2c2c2e transparent}.Empty{display:grid;place-items:center;height:100%;color:#48484a;font:500 12px/1.6 "SFMono-Regular",Consolas,monospace;text-align:center}.Line{display:grid;grid-template-columns:auto auto minmax(0,1fr);gap:9px;padding:5px 0;color:#d1d1d6;font:500 12px/1.55 "SFMono-Regular",Consolas,monospace;word-break:break-word;will-change:transform,opacity}.Prompt{color:var(--accent)}.Time{color:#48484a}.Message{color:#d1d1d6}
            .CaptchaPanel{margin-top:14px}.CaptchaPanel[hidden]{display:none}.CaptchaBody{display:grid;place-items:center;min-height:340px;padding:10px;background:#000}.CaptchaFrame{display:block;width:min(420px,100%);height:320px;border:0;border-radius:10px;background:#fff}
            .DestinationAction{display:flex;padding:16px 0 4px;gap:9px;flex-wrap:wrap}.DestinationButton{display:inline-flex;align-items:center;justify-content:center;min-height:46px;padding:0 18px;border:1px solid var(--accent);border-radius:10px;background:var(--accent);color:#00130f;font:800 11px/1 "SFMono-Regular",Consolas,monospace;letter-spacing:.065em;text-decoration:none;cursor:pointer}
            .KeyPanel{margin:14px 0 4px;border:1px solid #1c1c1e;border-radius:12px;overflow:hidden;background:#050505}.KeyPanel[hidden]{display:none}.KeyHead{display:flex;align-items:center;justify-content:space-between;padding:10px 14px;border-bottom:1px solid #1c1c1e;background:#080808}.KeyLabel{color:var(--accent);font:700 10px/1 "SFMono-Regular",Consolas,monospace;letter-spacing:.14em;text-transform:uppercase}.KeyMeta{color:#8e8e93;font:600 12px/1 "SFMono-Regular",Consolas,monospace;letter-spacing:.04em}.KeyValue{padding:14px;font:600 13px/1.6 "SFMono-Regular",Consolas,monospace;color:#f5f5f7;word-break:break-all;-webkit-user-select:all;user-select:all;max-height:120px;overflow:auto}
            @keyframes TitleReflection{0%,70%{background-position:180% 0}100%{background-position:-130% 0}}
            @media(max-width:620px){.Stage{place-items:start center;padding:24px 14px}.Hero{margin-bottom:20px}.TitleLockup{gap:9px}h1{font-size:clamp(1.65rem,9.3vw,2.35rem)}.AhstLockup{gap:3px;padding-bottom:2px}.AhstName{font-size:13px}.AhstLong{max-width:78px;font-size:7.5px;letter-spacing:.035em}.Console,.CaptchaPanel{border-radius:13px}.ConsoleBody{height:52dvh;padding:12px 13px}.CaptchaBody{min-height:300px;padding:6px}.CaptchaFrame{height:min(320px,48dvh)}.DestinationButton{width:100%}}
            @media(max-height:720px) and (min-width:621px){.Stage{place-items:start center}.ConsoleBody{height:46vh}}
            @media(prefers-reduced-motion:reduce){.Glass,.Line{will-change:auto}.TitleText::after{animation:none;background:none}}
            :host(.dock){position:fixed!important;inset:auto 12px 12px 12px!important;width:auto!important;height:auto!important;max-height:220px!important;background:transparent!important;pointer-events:none!important;overflow:visible!important}
            :host(.dock) .App{position:relative;inset:auto;min-height:0;background:transparent}
            :host(.dock) .Stage{display:block;min-height:0;padding:0}
            :host(.dock) .Hero,:host(.dock) .KeyPanel,:host(.dock) .CaptchaPanel{display:none}
            :host(.dock) .Glass{width:min(560px,100%);margin-left:auto;pointer-events:auto}
            :host(.dock) .ConsoleBody{height:132px}
            :host(.captcha-open){background:transparent!important;pointer-events:none!important}
            :host(.captcha-open) .App{background:transparent!important;pointer-events:none!important}
            :host(.captcha-open) .Stage{min-height:0;display:block;padding:0}
            :host(.captcha-open) .Glass{pointer-events:auto;position:fixed;left:50%;bottom:16px;width:min(720px,calc(100% - 24px));transform:translateX(-50%)}
        </style>
        <div class="App" data-state="active" role="dialog" aria-modal="true" aria-labelledby="pp-title">
            <main class="Stage"><section class="Glass"><div class="Inner">
                <header class="Hero"><div class="TitleLockup"><h1 id="pp-title"><span class="TitleText" data-title="Polar Patcher">Polar Patcher</span></h1><span class="AhstLockup"><strong class="AhstName">AHST</strong><span class="AhstLong">Anti-Hambreado Script team</span></span></div><p class="Subtitle">TheRealBanHammer</p></header>
                <section class="Console" aria-label="Consola de progreso"><div class="ConsoleHead"><span class="TerminalDots" aria-hidden="true"><i></i><i></i><i></i></span><span class="ConsoleTitle">Consola</span><span class="WaitTotal" hidden></span></div><div class="ConsoleBody" aria-live="polite"><div class="Empty">Esperando…</div></div></section>
                <section class="KeyPanel" hidden><div class="KeyHead"><span class="KeyLabel">Key</span><span class="KeyMeta"></span></div><div class="KeyValue"></div></section>
                <section class="CaptchaPanel" hidden aria-label="Comprobación de LootLabs"><div class="ConsoleHead"><span class="TerminalDots" aria-hidden="true"><i></i><i></i><i></i></span><span class="ConsoleTitle">Comprobación de LootLabs</span></div><div class="CaptchaBody"><iframe class="CaptchaFrame" title="Captcha de LootLabs"></iframe></div></section>
            </div></section></main>
        </div>`;

    const Ui = {
        root: Shadow.querySelector(".App"),
        glass: Shadow.querySelector(".Glass"),
        consoleBody: Shadow.querySelector(".ConsoleBody"),
        waitTotal: Shadow.querySelector(".WaitTotal"),
        captchaPanel: Shadow.querySelector(".CaptchaPanel"),
        captchaFrame: Shadow.querySelector(".CaptchaFrame"),
        keyPanel: Shadow.querySelector(".KeyPanel"),
        keyMeta: Shadow.querySelector(".KeyMeta"),
        keyValue: Shadow.querySelector(".KeyValue")
    };

    function IsHttpUrl(Value) {
        try {
            return /^https?:$/.test(new URL(Value, Window.location.href).protocol);
        } catch (ErrorValue) {
            return false;
        }
    }

    function UiShouldStayRaised() {
        return UiMounted && UiHost.style.display !== "none" && UiHost.style.opacity !== "0" && UiHost.style.pointerEvents !== "none";
    }

    function InstallUiTopStyle() {
        const Existing = Document.getElementById("pp-top-style");
        const Dock = UiHost.classList.contains("dock");
        const Loot = UiHost.classList.contains("loot");
        const Text = Dock
            ? "#polar-patcher-ahst.dock{position:fixed!important;left:12px!important;right:12px!important;bottom:12px!important;top:auto!important;width:auto!important;height:auto!important;max-height:220px!important;margin:0!important;background:transparent!important;pointer-events:none!important;z-index:2147483646!important;overflow:visible!important}"
            : Loot
                ? "#polar-patcher-ahst.loot,#polar-patcher-ahst.loot:popover-open{position:fixed!important;inset:0!important;width:100vw!important;height:100vh!important;max-width:none!important;max-height:none!important;margin:0!important;padding:0!important;border:none!important;background:#000!important;z-index:2147483647!important;display:block!important;pointer-events:auto!important;overflow:auto!important}"
                : "#polar-patcher-ahst,#polar-patcher-ahst:popover-open{position:fixed!important;inset:0!important;width:100vw!important;height:100vh!important;max-width:none!important;max-height:none!important;margin:0!important;padding:0!important;border:none!important;background:#000!important;z-index:2147483647!important;display:block!important;pointer-events:auto!important;overflow:auto!important}";
        if (Existing) {
            Existing.textContent = Text;
            return;
        }
        const Style = Document.createElement("style");
        Style.id = "pp-top-style";
        Style.textContent = Text;
        (Document.head || Document.documentElement).appendChild(Style);
    }

    let UiRaiseBusy = false;
    function RaiseUiHost(ForceTopLayer) {
        if (!UiShouldStayRaised() || UiRaiseBusy) return;
        UiRaiseBusy = true;
        try {
            InstallUiTopStyle();
            const Root = Document.body || Document.documentElement;
            if (!Root) return;
            if (UiHost.parentNode !== Root || Root.lastElementChild !== UiHost) {
                try {
                    Root.appendChild(UiHost);
                } catch (ErrorValue) {}
            }
            UiHost.style.zIndex = UiHost.classList.contains("captcha-open") ? "1" : "2147483647";
            if (UiHost.classList.contains("dock") || UiHost.classList.contains("captcha-open")) {
                if (UiHost.classList.contains("captcha-open") && typeof UiHost.hidePopover === "function") {
                    try {
                        UiHost.hidePopover();
                    } catch (ErrorValue) {}
                }
                return;
            }
            if (typeof UiHost.showPopover === "function") {
                try {
                    const Open = UiHost.matches(":popover-open");
                    const Rival = Array.prototype.some.call(Document.querySelectorAll("dialog[open], [popover]:popover-open"), function (Node) {
                        return Node !== UiHost;
                    });
                    if (!Open) UiHost.showPopover();
                    else if (ForceTopLayer || Rival) {
                        UiHost.hidePopover();
                        UiHost.showPopover();
                    }
                } catch (ErrorValue) {
                    try {
                        UiHost.showPopover();
                    } catch (Nested) {}
                }
            }
        } finally {
            UiRaiseBusy = false;
        }
    }

    function KeepUiOnTop() {
        if (Window.__polarUiTopKeeperInstalled) return;
        Window.__polarUiTopKeeperInstalled = true;
        RaiseUiHost(true);
        setInterval(function () {
            RaiseUiHost(false);
        }, 400);
        try {
            new MutationObserver(function (Records) {
                const Foreign = Records.some(function (Record) {
                    return Array.prototype.some.call(Record.addedNodes, function (Node) {
                        return Node !== UiHost && Node.id !== "pp-top-style";
                    });
                });
                if (Foreign) RaiseUiHost(true);
            }).observe(Document.documentElement, { childList: true, subtree: false });
            if (Document.body) {
                new MutationObserver(function (Records) {
                    const Foreign = Records.some(function (Record) {
                        return Array.prototype.some.call(Record.addedNodes, function (Node) {
                            return Node !== UiHost;
                        });
                    });
                    if (Foreign) RaiseUiHost(true);
                }).observe(Document.body, { childList: true, subtree: false });
            }
        } catch (ErrorValue) {}
        Document.addEventListener("fullscreenchange", function () {
            RaiseUiHost(true);
        }, true);
    }

    function MountUi(Mode) {
        if (UiMounted) return;
        if (Mode === "loot") {
            UiHost.classList.add("loot");
            UiHost.setAttribute("popover", "manual");
            UiHost.style.zIndex = "2147483647";
        }
        (Document.body || Document.documentElement || Document).appendChild(UiHost);
        UiMounted = true;
        KeepUiOnTop();
        InstallUiTopStyle();
        DebugState.status.forEach(function (Entry) {
            RenderStatus(Entry, false);
        });
        if (!ReduceMotion) {
            Ui.root.animate([{ opacity: 0 }, { opacity: 1 }], { duration: 420, easing: "cubic-bezier(.2,0,0,1)", fill: "both" });
            Ui.glass.animate([
                { opacity: 0, transform: "translateY(24px) scale(.94)" },
                { opacity: 1, transform: "translateY(0) scale(1)" }
            ], { duration: 680, easing: "cubic-bezier(.16,1,.3,1)", fill: "both" });
        }
    }

    function RenderStatus(Entry, Animate) {
        const Empty = Ui.consoleBody.querySelector(".Empty");
        if (Empty) Empty.remove();
        const Line = Document.createElement("div");
        const Prompt = Document.createElement("span");
        const Time = Document.createElement("span");
        const Message = Document.createElement("span");
        Line.className = "Line";
        Prompt.className = "Prompt";
        Prompt.textContent = ">";
        Time.className = "Time";
        Time.textContent = "[" + new Date(Entry.time).toLocaleTimeString("es-MX", { hour12: false, hour: "2-digit", minute: "2-digit", second: "2-digit" }) + "]";
        Message.className = "Message";
        Message.textContent = Entry.message;
        Line.append(Prompt, Time, Message);
        Ui.consoleBody.append(Line);
        while (Ui.consoleBody.querySelectorAll(".Line").length > 100) {
            const First = Ui.consoleBody.querySelector(".Line");
            if (First) First.remove();
        }
        Ui.consoleBody.scrollTop = Ui.consoleBody.scrollHeight;
        if (Animate && !ReduceMotion) {
            Line.animate([
                { opacity: 0, transform: "translateY(8px) scale(.99)" },
                { opacity: 1, transform: "translateY(0) scale(1)" }
            ], { duration: 360, easing: "cubic-bezier(.16,1,.3,1)", fill: "both" });
        }
    }

    function UpdateStatus(Message, Force) {
        if (!Force && Message === LastStatus) return;
        LastStatus = Message;
        const Entry = { time: Date.now(), message: Message };
        DebugState.phase = Message;
        DebugState.status.push(Entry);
        if (DebugState.status.length > 100) DebugState.status.shift();
        if (UiMounted) RenderStatus(Entry, true);
        console.log("[Polar Patcher - AHST]", Message);
    }

    function Fail(Message, ErrorValue) {
        DebugState.failure = {
            time: Date.now(),
            message: Message,
            error: ErrorValue && (ErrorValue.stack || ErrorValue.message) || (ErrorValue ? String(ErrorValue) : null)
        };
        Ui.root.dataset.state = "error";
        UpdateStatus("Error: " + Message, true);
        if (ErrorValue) console.error("[Polar Patcher - AHST]", ErrorValue);
    }

    function IsLootHost(Host) {
        Host = String(Host || "").toLowerCase();
        return LootHosts.some(function (Domain) {
            return Host === Domain || Host.endsWith("." + Domain);
        });
    }

    function ReadEntry() {
        try {
            return JSON.parse(Window.localStorage.getItem(EntryKey) || "{}") || {};
        } catch (ErrorValue) {
            return {};
        }
    }

    function WriteEntry(Patch) {
        const Next = ReadEntry();
        Object.keys(Patch).forEach(function (Key) {
            if (Patch[Key]) Next[Key] = Patch[Key];
        });
        try {
            Window.localStorage.setItem(EntryKey, JSON.stringify(Next));
        } catch (ErrorValue) {}
        DebugState.polar.entry = Next;
        return Next;
    }

    function RewriteLootUrl(Value) {
        const Target = new URL(Value, Window.location.href);
        if (!IsLootHost(Target.hostname)) return Target.href;
        Target.protocol = "https:";
        Target.hostname = "links.lootlabs.gg";
        return Target.href;
    }

    function RememberFromUrl(Value) {
        try {
            const Target = new URL(Value, Window.location.href);
            const Patch = {};
            const AppId = Target.searchParams.get("app_id");
            const Hwid = Target.searchParams.get("hardwareIdentifier") || Target.searchParams.get("puid");
            if (AppId) Patch.appId = AppId;
            if (Hwid) Patch.hwid = Hwid;
            if (IsLootHost(Target.hostname) && (Target.searchParams.has("data") || Target.searchParams.has("puid"))) {
                Patch.loot = RewriteLootUrl(Target.href);
            }
            if (Object.keys(Patch).length) WriteEntry(Patch);
        } catch (ErrorValue) {}
    }

    function GatewayForThisUser() {
        const Entry = ReadEntry();
        let AppId = Entry.appId || "polarmods.patcher";
        let Hwid = Entry.hwid || "";
        try {
            const Here = new URL(Window.location.href);
            AppId = Here.searchParams.get("app_id") || AppId;
            Hwid = Here.searchParams.get("hardwareIdentifier") || Here.searchParams.get("puid") || Hwid;
        } catch (ErrorValue) {}
        if (!Hwid) return "";
        return "https://bombhacker.pro/gateway?app_id=" + encodeURIComponent(AppId) + "&hardwareIdentifier=" + encodeURIComponent(Hwid);
    }

    function ClearPolarCookies(Done) {
        ["session_id", "app_id", "hardwareIdentifier"].forEach(function (Name) {
            Document.cookie = Name + "=; Path=/; Max-Age=0";
            Document.cookie = Name + "=; Path=/; Domain=bombhacker.pro; Max-Age=0";
            Document.cookie = Name + "=; Path=/; Domain=.bombhacker.pro; Max-Age=0";
        });
        const CookieApi = typeof GM_cookie !== "undefined" ? GM_cookie : null;
        if (!CookieApi || typeof CookieApi.delete !== "function") {
            Done();
            return;
        }
        const Names = ["session_id", "app_id", "hardwareIdentifier"];
        let Left = Names.length;
        Names.forEach(function (Name) {
            try {
                CookieApi.delete({ url: "https://bombhacker.pro/", name: Name }, function () {
                    Left -= 1;
                    if (Left <= 0) Done();
                });
            } catch (ErrorValue) {
                Left -= 1;
                if (Left <= 0) Done();
            }
        });
    }

    function SameUrl(Left, Right) {
        try {
            return new URL(Left, Window.location.href).href === new URL(Right, Window.location.href).href;
        } catch (ErrorValue) {
            return Left === Right;
        }
    }

    function NavigateTo(Destination, Force) {
        if (LeftPage && !Force) return;
        LeftPage = true;
        Document.querySelectorAll('meta[name="referrer"]').forEach(function (Node) {
            Node.remove();
        });
        const Link = Document.createElement("a");
        Link.href = Destination;
        Link.referrerPolicy = "unsafe-url";
        Link.hidden = true;
        (Document.body || Document.documentElement).appendChild(Link);
        Link.click();
        setTimeout(function () {
            if (Window.location.href === Destination) return;
            try {
                Window.location.assign(Destination);
            } catch (ErrorValue) {
                Window.location.href = Destination;
            }
        }, 400);
    }


    function ShowKey(Value, Meta) {
        if (!Value || !Ui.keyPanel) return;
        Ui.keyValue.textContent = Value;
        if (Ui.keyMeta) Ui.keyMeta.textContent = Meta || "";
        Ui.keyPanel.hidden = false;
        DebugState.polar.key = Value;
    }

    function IsCaptchaHost(Host) {
        Host = String(Host || "").toLowerCase();
        return Host === "challenges.cloudflare.com" || Host.endsWith(".challenges.cloudflare.com") || /(^|\.)nerventualken\.com$/.test(Host) || Host === "hcaptcha.com" || Host.endsWith(".hcaptcha.com") || Host === "www.recaptcha.net" || Host.endsWith(".recaptcha.net");
    }

    function AllowNavigation(Value) {
        if (Value == null || Value === "" || Value === "about:blank") return true;
        let Target;
        try {
            Target = new URL(String(Value), Window.location.href);
        } catch (ErrorValue) {
            return false;
        }
        if (Target.protocol !== "http:" && Target.protocol !== "https:") return true;
        const Host = Target.hostname.toLowerCase();
        if (Host === Window.location.hostname.toLowerCase()) return true;
        if (Host === "bombhacker.pro" || Host.endsWith(".bombhacker.pro")) return true;
        if (IsCaptchaHost(Host)) return true;
        return false;
    }

    function InstallRedirectGuard() {
        if (Window.__polarRedirectGuard) return;
        Window.__polarRedirectGuard = true;
        const NativeOpen = Window.open;
        Window.open = function (Url) {
            if (AllowNavigation(Url)) return NativeOpen.apply(Window, arguments);
            UpdateStatus("Redirección bloqueada.", true);
            return null;
        };
        ["assign", "replace"].forEach(function (Name) {
            const Original = Window.Location && Window.Location.prototype && Window.Location.prototype[Name];
            if (typeof Original !== "function") return;
            try {
                Window.Location.prototype[Name] = function (Url) {
                    if (!AllowNavigation(Url)) {
                        UpdateStatus("Redirección bloqueada.", true);
                        return;
                    }
                    return Original.call(this, Url);
                };
            } catch (ErrorValue) {}
        });
        try {
            const Href = Object.getOwnPropertyDescriptor(Window.Location.prototype, "href");
            if (Href && Href.set && Href.configurable) {
                Object.defineProperty(Window.Location.prototype, "href", {
                    configurable: true,
                    enumerable: Href.enumerable,
                    get: function () {
                        return Href.get.call(this);
                    },
                    set: function (Url) {
                        if (!AllowNavigation(Url)) {
                            UpdateStatus("Redirección bloqueada.", true);
                            return;
                        }
                        Href.set.call(this, Url);
                    }
                });
            }
        } catch (ErrorValue) {}
        Document.addEventListener("click", function (Event) {
            const Link = Event.target && Event.target.closest && Event.target.closest("a[href]");
            if (!Link || AllowNavigation(Link.href)) return;
            Event.preventDefault();
        }, true);
        const DropRefresh = function () {
            Document.querySelectorAll("meta[http-equiv='refresh' i]").forEach(function (Node) {
                Node.remove();
            });
        };
        DropRefresh();
        try {
            new MutationObserver(DropRefresh).observe(Document.documentElement, { childList: true, subtree: true });
        } catch (ErrorValue) {}
    }

    function PlainText(Node) {
        return String((Node && (Node.innerText || Node.textContent)) || "").replace(/\s+/g, " ").trim();
    }

    function FormatWait(Seconds) {
        Seconds = Math.max(0, Math.round(Seconds));
        if (Seconds >= 60 && Seconds % 60 === 0) return (Seconds / 60) + "m";
        if (Seconds >= 90) return Math.floor(Seconds / 60) + "m " + (Seconds % 60) + "s";
        return Seconds + "s";
    }

    function SecondsIn(Text) {
        const Source = String(Text || "");
        const Pattern = /~\s*(\d+(?:[.,]\d+)?)\s*(minutes?|mins?|min|seconds?|secs?|sec)\b/gi;
        let Total = 0;
        let Match;
        while ((Match = Pattern.exec(Source))) {
            const Amount = Number(Match[1].replace(",", "."));
            if (!Amount) continue;
            Total += /^min/i.test(Match[2]) ? Amount * 60 : Amount;
        }
        return Total;
    }

    function EachNode(Root, Visit) {
        if (!Root || !Root.querySelectorAll) return;
        const Nodes = Root.querySelectorAll("*");
        let Index;
        for (Index = 0; Index < Nodes.length; Index += 1) {
            const Node = Nodes[Index];
            Visit(Node);
            if (Node.shadowRoot) EachNode(Node.shadowRoot, Visit);
        }
    }

    let WaitBase = 0;
    let WaitAnchor = 0;
    function MissionWait() {
        const Hits = [];
        EachNode(Document.body || Document.documentElement, function (Node) {
            if (Node.closest && Node.closest("#polar-patcher-ahst")) return;
            const Text = PlainText(Node);
            if (Text.length < 2 || Text.length > 64) return;
            if (!SecondsIn(Text)) return;
            Hits.push(Node);
        });
        const Leaves = Hits.filter(function (Node) {
            return !Hits.some(function (Other) {
                return Other !== Node && Node.contains(Other);
            });
        });
        let Total = 0;
        Leaves.forEach(function (Node) {
            Total += SecondsIn(PlainText(Node));
        });
        return Total;
    }

    function ShowRemaining(Total) {
        if (!Total) {
            WaitBase = 0;
            WaitAnchor = 0;
            ShowWait(0);
            return;
        }
        if (Total !== WaitBase) {
            WaitBase = Total;
            WaitAnchor = Date.now();
        }
        const Left = Math.max(0, WaitBase - (Date.now() - WaitAnchor) / 1000);
        ShowWait(Left);
    }

    function SetCaptchaOpen(Open) {
        UiHost.classList.toggle("captcha-open", Open);
        if (Open) {
            UiHost.style.zIndex = "1";
            UiHost.style.background = "transparent";
            UiHost.style.pointerEvents = "none";
            if (typeof UiHost.hidePopover === "function") {
                try {
                    UiHost.hidePopover();
                } catch (ErrorValue) {}
            }
            return;
        }
        UiHost.style.zIndex = "2147483647";
        UiHost.style.background = "#000";
        UiHost.style.pointerEvents = "auto";
        RaiseUiHost(true);
    }

    function ShowWait(Seconds) {
        if (!Ui.waitTotal) return;
        if (!Seconds) {
            Ui.waitTotal.hidden = true;
            Ui.waitTotal.textContent = "";
            return;
        }
        Ui.waitTotal.hidden = false;
        Ui.waitTotal.textContent = FormatWait(Seconds);
    }

    function RaiseNode(Node) {
        if (!Node || (Node.closest && Node.closest("#polar-patcher-ahst"))) return;
        Node.style.setProperty("position", "fixed", "important");
        Node.style.setProperty("z-index", "2147483647", "important");
        Node.style.setProperty("left", "50%", "important");
        Node.style.setProperty("top", "22vh", "important");
        Node.style.setProperty("transform", "translateX(-50%)", "important");
        Node.style.setProperty("pointer-events", "auto", "important");
        Node.style.setProperty("margin", "0", "important");
        try {
            Node.setAttribute("popover", "manual");
            if (typeof Node.showPopover === "function") Node.showPopover();
        } catch (ErrorValue) {}
    }

    function LiftCaptcha() {
        const Frames = Document.querySelectorAll("iframe");
        let Index;
        for (Index = 0; Index < Frames.length; Index += 1) {
            const Frame = Frames[Index];
            if (Frame.closest && Frame.closest("#polar-patcher-ahst")) continue;
            const Src = String(Frame.src || "").toLowerCase();
            const Rect = Frame.getBoundingClientRect();
            if (Rect.width < 48 || Rect.height < 40) continue;
            if (!/cloudflare|turnstile|hcaptcha|recaptcha|nerventualken|captcha/.test(Src)) continue;
            const Box = Frame.parentElement && Frame.parentElement !== Document.body ? Frame.parentElement : Frame;
            RaiseNode(Box);
            Frame.style.setProperty("pointer-events", "auto", "important");
        }
        Document.querySelectorAll(".cf-turnstile, #challenge-stage, #cf-challenge-running").forEach(function (Widget) {
            RaiseNode(Widget);
        });
    }

    function CaptchaWaiting() {
        const Frames = Document.querySelectorAll("iframe");
        let Index;
        for (Index = 0; Index < Frames.length; Index += 1) {
            const Frame = Frames[Index];
            if (Frame.closest && Frame.closest("#polar-patcher-ahst")) continue;
            const Src = String(Frame.src || "").toLowerCase();
            const Rect = Frame.getBoundingClientRect();
            if (Rect.width < 48 || Rect.height < 40) continue;
            if (/cloudflare|turnstile|hcaptcha|recaptcha|nerventualken|captcha/.test(Src)) return true;
        }
        return !!Document.querySelector("#challenge-stage, #cf-challenge-running, .cf-turnstile iframe");
    }

    function Press(Node) {
        ["pointerdown", "mousedown", "pointerup", "mouseup", "click"].forEach(function (Type) {
            Node.dispatchEvent(new MouseEvent(Type, { bubbles: true, cancelable: true, view: Window }));
        });
        if (typeof Node.click === "function") Node.click();
    }

    function TaskCards() {
        const Nodes = Document.querySelectorAll("a, button, [role='button'], div, li");
        const Cards = [];
        let Index;
        for (Index = 0; Index < Nodes.length; Index += 1) {
            const Node = Nodes[Index];
            if (Node.closest && Node.closest("#polar-patcher-ahst")) continue;
            const Text = PlainText(Node);
            if (Text.length < 12 || Text.length > 220) continue;
            if (/complete tasks to continue/i.test(Text)) continue;
            if (/claim reward/i.test(Text)) continue;
            const Rect = Node.getBoundingClientRect();
            if (Rect.width < 160 || Rect.height < 40 || Rect.height > 180) continue;
            const Style = Window.getComputedStyle(Node);
            const Clickable = Style.cursor === "pointer" || Node.tagName === "A" || Node.tagName === "BUTTON" || Node.getAttribute("role") === "button";
            if (!Clickable || Style.display === "none" || Style.visibility === "hidden") continue;
            Cards.push(Node);
        }
        return Cards.filter(function (Node) {
            return !Cards.some(function (Other) {
                return Other !== Node && Node.contains(Other);
            });
        });
    }

    function ClaimControl() {
        const Nodes = Document.querySelectorAll("a, button, [role='button'], div");
        let Index;
        for (Index = 0; Index < Nodes.length; Index += 1) {
            const Node = Nodes[Index];
            if (Node.closest && Node.closest("#polar-patcher-ahst")) continue;
            const Label = PlainText(Node);
            if (!/claim reward/i.test(Label) || Label.length > 40) continue;
            const Rect = Node.getBoundingClientRect();
            if (Rect.width < 80 || Rect.height < 24) continue;
            if (Node.disabled || Node.getAttribute("aria-disabled") === "true") return null;
            const Style = Window.getComputedStyle(Node);
            if (Style.pointerEvents === "none" || Style.cursor === "not-allowed" || Number(Style.opacity) < 0.5) return null;
            if (Node.querySelector("[class*='lock'], .fa-lock")) return null;
            return Node;
        }
        return null;
    }

    function RunLootTasks() {
        InstallRedirectGuard();
        const Done = new Set();
        UpdateStatus("Admaven a la vista. Bloqueo sus salidas y pulso las misiones. El captcha es tuyo.", true);
        const Timer = setInterval(function () {
            const Cards = TaskCards();
            ShowRemaining(MissionWait());
            if (CaptchaWaiting()) {
                SetCaptchaOpen(true);
                LiftCaptcha();
                UpdateStatus("Hay un captcha. Resuélvelo; sigo cuando se cierre.");
                return;
            }
            SetCaptchaOpen(false);
            const Claim = ClaimControl();
            if (Claim) {
                clearInterval(Timer);
                UpdateStatus("Misiones listas. Pulso Claim Reward.", true);
                Press(Claim);
                return;
            }
            let Index;
            for (Index = 0; Index < Cards.length; Index += 1) {
                const Card = Cards[Index];
                const Label = PlainText(Card);
                if (Done.has(Label)) continue;
                Done.add(Label);
                UpdateStatus("Misión: " + Label.slice(0, 80), true);
                Press(Card);
                return;
            }
        }, 1400);
    }

    function PageText() {
        const Body = Document.body;
        return Body ? String(Body.innerText || Body.textContent || "").replace(/\s+/g, " ").trim() : "";
    }

    function IsHexData(Value) {
        return typeof Value === "string" && /^[0-9a-fA-F]{16,}$/.test(Value);
    }

    function IsPolarFinishUrl(Value) {
        try {
            const Target = new URL(Value, Window.location.href);
            const Host = Target.hostname.toLowerCase();
            if (Host !== "bombhacker.pro" && !Host.endsWith(".bombhacker.pro")) return false;
            if (!/\/gateway\/?$/i.test(Target.pathname)) return false;
            return IsHexData(Target.searchParams.get("data"));
        } catch (ErrorValue) {
            return false;
        }
    }

    function IsPolarFinishDocument() {
        if (!IsPolar) return false;
        if (IsPolarFinishUrl(Window.location.href)) return true;
        if (Document.querySelector(".cf-turnstile, script[src*='gateway_finish.js']")) return true;
        return /all links are complete/i.test(PageText());
    }

    function ShowFinishPage() {
        if (!UiMounted) MountUi("loot");
        UpdateStatus("Enlaces listos. Resuelve el Cloudflare de encima para terminar.", true);
        const Timer = setInterval(function () {
            SetCaptchaOpen(true);
            LiftCaptcha();
            const Key = ReadVisibleKey();
            if (Key) {
                clearInterval(Timer);
                ShowKey(Key);
            }
        }, 400);
    }

    function ReleaseFinishPage() {
        const Host = Document.getElementById("polar-patcher-ahst");
        const Style = Document.getElementById("pp-top-style");
        if (typeof UiHost.hidePopover === "function") {
            try {
                UiHost.hidePopover();
            } catch (ErrorValue) {}
        }
        if (Host && Host.parentNode) Host.remove();
        if (Style && Style.parentNode) Style.remove();
        UiMounted = false;
        UiHost.style.display = "none";
        UiHost.style.pointerEvents = "none";
        DebugState.polar.finish = true;
        console.log("[Polar Patcher - AHST] Página final. El Turnstile queda libre.");
    }

    function ReadGatewayUrl() {
        const Marked = Document.querySelector("[data-url]");
        const MarkedUrl = Marked && Marked.getAttribute("data-url");
        if (MarkedUrl && IsHttpUrl(MarkedUrl)) return MarkedUrl;
        const Links = Document.querySelectorAll("a[href]");
        let Index;
        for (Index = 0; Index < Links.length; Index += 1) {
            const Href = Links[Index].href;
            if (!IsHttpUrl(Href)) continue;
            try {
                if (IsLootHost(new URL(Href).hostname)) return Href;
            } catch (ErrorValue) {}
        }
        return "";
    }

    function RetryGateway(Code) {
        const Target = GatewayForThisUser();
        let LastRetry = 0;
        try {
            LastRetry = Number(Window.sessionStorage.getItem(RetryKey) || "0");
        } catch (ErrorValue) {}
        if (!Target || Date.now() - LastRetry < 90000) {
            Fail(Code + ". Polar rechazó la sesión de este hardware. Vuelve a abrir tu enlace del gateway.");
            return;
        }
        try {
            Window.sessionStorage.setItem(RetryKey, String(Date.now()));
        } catch (ErrorValue) {}
        UpdateStatus("Error " + Code + ". Limpio la sesión y entro de nuevo con tu hardwareIdentifier…", true);
        ClearPolarCookies(function () {
            NavigateTo(Target, true);
        });
    }

    function ReadVisibleKey() {
        const Nodes = Document.querySelectorAll("input, textarea, code, .key, #key, [data-key]");
        let Index;
        for (Index = 0; Index < Nodes.length; Index += 1) {
            const Node = Nodes[Index];
            if (Node.closest && Node.closest("#polar-patcher-ahst")) continue;
            const Value = String(Node.value || Node.getAttribute("data-key") || Node.textContent || "").trim();
            if (Value.length >= 8 && Value.length <= 128 && !/\s/.test(Value) && !/^https?:/i.test(Value)) return Value;
        }
        const Match = PageText().match(/key\s*[:：]\s*([A-Za-z0-9_-]{8,})/i);
        return Match ? Match[1] : "";
    }

    function BootPolar() {
        const Started = Date.now();
        let SawSomething = false;
        UpdateStatus("Polar Patcher " + Build + " cargado. Esperando el gateway…");
        const Timer = setInterval(function () {
            if (IsPolarFinishDocument()) {
                clearInterval(Timer);
                ShowFinishPage();
                return;
            }
            const GatewayUrl = ReadGatewayUrl();
            if (GatewayUrl) {
                clearInterval(Timer);
                SawSomething = true;
                let Puid = "";
                let HasData = false;
                try {
                    const Target = new URL(GatewayUrl);
                    Puid = Target.searchParams.get("puid") || "";
                    HasData = Target.searchParams.has("data");
                } catch (ErrorValue) {}
                RememberFromUrl(GatewayUrl);
                const Direct = RewriteLootUrl(GatewayUrl);
                DebugState.polar.gateway = Direct;
                UpdateStatus("Enlace de Admaven leído" + (Puid ? " para " + Puid : "") + ". data=" + (HasData ? "sí" : "no") + ". Abriendo LootLabs…", true);
                NavigateTo(Direct);
                return;
            }
            const Text = PageText();
            const ErrorMatch = Text.match(/error code\s*(\d+)/i);
            if (ErrorMatch) {
                clearInterval(Timer);
                SawSomething = true;
                const Code = ErrorMatch[1];
                DebugState.polar.error = Code;
                Fail(Code + ". Polar no aceptó esta vuelta. No reintento solo: eso te dejaba en bucle.");
                const Target = GatewayForThisUser();
                if (Target && Ui.consoleBody) {
                    const Action = Document.createElement("div");
                    const Button = Document.createElement("button");
                    Action.className = "DestinationAction";
                    Button.type = "button";
                    Button.className = "DestinationButton";
                    Button.textContent = "VOLVER A MI ENLACE";
                    Button.addEventListener("click", function () {
                        Button.disabled = true;
                        ClearPolarCookies(function () {
                            NavigateTo(Target, true);
                        });
                    });
                    Action.append(Button);
                    Ui.consoleBody.append(Action);
                }
                return;
            }
            const Key = ReadVisibleKey();
            if (Key) {
                clearInterval(Timer);
                SawSomething = true;
                DebugState.polar.key = Key;
                UpdateStatus("Key de Polar encontrada.", true);
                ShowKey(Key, "lista para copiar");
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    navigator.clipboard.writeText(Key).then(function () {
                        UpdateStatus("Key copiada al portapapeles.", true);
                    }).catch(function () {});
                }
                return;
            }
            if (!SawSomething && Date.now() - Started > 20000 && /\/gateway/i.test(Window.location.pathname)) {
                clearInterval(Timer);
                Fail("El gateway no mostró el enlace de Admaven ni una key.");
            }
            if (Date.now() - Started > 20000 && !/\/gateway/i.test(Window.location.pathname) && !ErrorMatch && !Key) {
                clearInterval(Timer);
                if (UiHost.parentNode) UiHost.remove();
                UiMounted = false;
            }
        }, 200);
    }

    function WhenBody(Callback) {
        if (Document.body) {
            Callback();
            return;
        }
        Document.addEventListener("DOMContentLoaded", Callback, { once: true });
    }

    RememberFromUrl(Window.location.href);
    if (IsLoot) {
        try {
            InstallRedirectGuard();
        } catch (ErrorValue) {}
    }
    Window.addEventListener("beforeunload", function () {
        LeftPage = true;
    });

    WhenBody(function () {
        if (IsPolarFinishDocument()) {
            ShowFinishPage();
            return;
        }
        if (IsLoot) {
            MountUi("loot");
            UpdateStatus("Polar Patcher " + Build + " cargado.");
            RunLootTasks();
            return;
        }
        MountUi();
        BootPolar();
    });
}();
