// ==UserScript==
// @name         Anti-SuaURL | Equipo A-HS
// @namespace    http://tampermonkey.net/
// @version      1.0.0
// @description  Bypass SuaURL | Anti-Hambreado Team.
// @author       TheRealBanHammer
// @icon         https://i.postimg.cc/8kv8w1Mn/Sua-URL-RIP.png
// @match        *://*.faiviral.com/*
// @match        *://faiviral.com/*
// @match        *://*.suaurl.com/*
// @match        *://suaurl.com/*
// @grant        none
// @run-at       document-start
// ==/UserScript==

// ██████╗░ ██╗ ██████╗░ ░░░░ ░█████╗░ ░█████╗░ ███╗░░░███╗ ██████╗░ ██╗ ░█████╗░ ███╗░░██╗ ███████╗ ░░░░░░ ░██████╗ ░█████╗░ ██████╗░ ██╗ ██████╗░ ████████╗
// ██╔══██╗ ██║ ██╔══██╗ ░░░░ ██╔══██╗ ██╔══██╗ ████╗░████║ ██╔══██╗ ██║ ██╔══██╗ ████╗░██║ ██╔════╝ ░░░░░░ ██╔════╝ ██╔══██╗ ██╔══██╗ ██║ ██╔══██╗ ╚══██╔══╝
// ██████╔╝ ██║ ██████╔╝ ░░░░ ██║░░╚═╝ ███████║ ██╔████╔██║ ██████╔╝ ██║ ██║░░██║ ██╔██╗██║ █████╗░░ █████╗ ╚█████╗░ ██║░░╚═╝ ██████╔╝ ██║ ██████╔╝ ░░░██║░░░
// ██╔══██╗ ██║ ██╔═══╝░ ░░░░ ██║░░██╗ ██╔══██║ ██║╚██╔╝██║ ██╔═══╝░ ██║ ██║░░██║ ██║╚████║ ██╔══╝░░ ╚════╝ ░╚═══██╗ ██║░░██╗ ██╔══██╗ ██║ ██╔═══╝░ ░░░██║░░░
// ██║░░██║ ██║ ██║░░░░░ ░░░░ ╚█████╔╝ ██║░░██║ ██║░╚═╝░██║ ██║░░░░░ ██║ ╚█████╔╝ ██║░╚███║ ███████╗ ░░░░░░ ██████╔╝ ╚█████╔╝ ██║░░██║ ██║ ██║░░░░░ ░░░██║░░░
// ╚═╝░░╚═╝ ╚═╝ ╚═╝░░░░░ ░░░░ ░╚════╝░ ╚═╝░░╚═╝ ╚═╝░░░░░╚═╝ ╚═╝░░░░░ ╚═╝ ░╚════╝░ ╚═╝░░╚══╝ ╚══════╝ ░░░░░░ ╚═════╝░ ░╚════╝░ ╚═╝░░╚═╝ ╚═╝ ╚═╝░░░░░ ░░░╚═╝░░░

(function() {
    'use strict';

    if (window.top !== window.self) return;

    let uiInjected = false;
    let statusEl, iconEl, uiEl;
    const openedWindows = [];
    let handshakeSent = false;

    try {
        const originalOpen = window.open;
        window.open = function(...args) {
            try {
                const win = originalOpen.apply(this, args);
                if (win) {
                    openedWindows.push(win);
                }
                return win;
            } catch (e) {
                return originalOpen.apply(this, args);
            }
        };
    } catch (e) {}

    function checkIsProxy() {
        try {
            if (checkIsSuaURL()) return false;

            const params = new URLSearchParams(window.location.search);
            const hasProxyParams = params.has('alias') || params.has('key') || params.has('p');

            const hostname = window.location.hostname.toLowerCase();
            const isKnownDomain = hostname.includes('faiviral') ||
                                  hostname.includes('favviral') ||
                                  hostname.includes('viral') ||
                                  hostname.includes('wizard') ||
                                  hostname.includes('executor');

            const text = document.body ? document.body.innerHTML.toLowerCase() : '';
            const hasProxyContent = text.includes('agu@rdand0') ||
                                    text.includes('aguarde mais') ||
                                    text.includes('etapa') ||
                                    text.includes('confirm') ||
                                    document.querySelector('#ADs-1') ||
                                    document.querySelector('.divAdsFind') ||
                                    document.querySelector('a[href*="suastore"]');

            return hasProxyParams || isKnownDomain || !!hasProxyContent;
        } catch (e) {
            return false;
        }
    }

    function checkIsSuaURL() {
        try {
            return window.location.hostname.includes('suaurl.com');
        } catch (e) {
            return false;
        }
    }

    window.addEventListener('message', (event) => {
        if (!event.data) return;

        if (event.data.type === 'suaurl-handshake-request') {
            try {
                event.source.postMessage({ type: 'suaurl-handshake-response' }, '*');
            } catch(e) {}
        }

        if (event.data.type === 'suaurl-handshake-response') {
            handshakeSent = true;
            window.isOpenedBySuaURL = true;

            if (document.body && document.readyState !== 'loading') {
                const isProxy = checkIsProxy();
                const isSuaURL = checkIsSuaURL();
                if (!isProxy && !isSuaURL) {
                    try {
                        window.close();
                    } catch(e) {}
                }
            }
        }

        if (event.data.type === 'suaurl-close-ads-only') {
            openedWindows.forEach(win => {
                try {
                    if (win && !win.closed && win !== event.source) {
                        win.close();
                    }
                } catch(e) {}
            });
        }

        if (event.data.type === 'suaurl-complete-and-refresh') {
            openedWindows.forEach(win => {
                try {
                    if (win && !win.closed) win.close();
                } catch(e) {}
            });
            setTimeout(() => {
                try {
                    window.location.replace(window.location.href);
                } catch(e) {}
            }, 1500);
        }
    });

    try {
        if (window.opener) {
            const handshakeInterval = setInterval(() => {
                if (handshakeSent) {
                    clearInterval(handshakeInterval);
                    return;
                }
                try {
                    window.opener.postMessage({ type: 'suaurl-handshake-request' }, '*');
                } catch(e) {}
            }, 500);
            setTimeout(() => clearInterval(handshakeInterval), 10000);
        }
    } catch (e) {}

    function injectUI() {
        if (uiInjected) return;
        uiInjected = true;

        const ui = document.createElement('div');
        ui.id = 'suaurl-ios-ui';
        ui.innerHTML = `
            <div class="ios-content">
                <div class="ios-icon" id="ios-spinner"></div>
                <div class="ios-text" id="ios-status">Inicializando...</div>
            </div>
        `;

        const style = document.createElement('style');
        style.textContent = `
            div[id^="divAdsFind"], div[id^="ADs-"], img[alt="Publicidade"], .divAdsFind {
                opacity: 0.001 !important;
                height: 1px !important;
                overflow: hidden !important;
                position: absolute !important;
                pointer-events: none !important;
            }

            #suaurl-ios-ui {
                position: fixed;
                bottom: 45px;
                left: 50%;
                transform: translateX(-50%) scale(0.9);
                background: rgba(20, 20, 22, 0.85);
                backdrop-filter: blur(30px) saturate(250%);
                -webkit-backdrop-filter: blur(30px) saturate(250%);
                border: 1px solid rgba(255, 255, 255, 0.12);
                border-radius: 50px;
                padding: 14px 28px;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3), 0 0 0 1px rgba(255,255,255,0.05) inset;
                z-index: 2147483647;
                color: #ffffff;
                font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Helvetica Neue", sans-serif;
                display: flex;
                align-items: center;
                opacity: 0;
                animation: iosReveal 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
                pointer-events: none;
                transition: all 0.5s cubic-bezier(0.16, 1, 0.3, 1);
            }

            #suaurl-ios-ui.mode-captcha {
                background: rgba(255, 149, 0, 0.9);
                box-shadow: 0 20px 50px rgba(255, 149, 0, 0.35), 0 0 0 1px rgba(255,255,255,0.2) inset;
            }

            #suaurl-ios-ui.mode-success {
                background: rgba(48, 209, 88, 0.9);
                box-shadow: 0 20px 50px rgba(48, 209, 88, 0.35), 0 0 0 1px rgba(255,255,255,0.2) inset;
            }

            .ios-content { display: flex; align-items: center; gap: 16px; }
            .ios-text { font-size: 16px; font-weight: 600; letter-spacing: -0.4px; white-space: nowrap; }

            .ios-icon {
                width: 22px; height: 22px; border-radius: 50%;
                border: 2.5px solid rgba(255, 255, 255, 0.25);
                border-top-color: #ffffff;
                animation: iosRotate 0.9s cubic-bezier(0.4, 0, 0.2, 1) infinite;
            }

            .ios-icon.type-warning {
                border: none !important; animation: none !important; background: #ffffff !important;
                display: flex !important; justify-content: center !important; align-items: center !important;
                color: #FF9500 !important; font-weight: 700 !important; font-size: 15px !important;
            }
            .ios-icon.type-warning::after {
                content: "!" !important;
                margin: 0 !important;
                padding: 0 !important;
                line-height: 1 !important;
                display: inline-block !important;
                text-align: center !important;
            }

            .ios-icon.type-check {
                border: none !important; animation: none !important; background: #ffffff !important;
                display: flex !important; justify-content: center !important; align-items: center !important;
                color: #30D158 !important; font-size: 13px !important;
            }
            .ios-icon.type-check::after {
                content: "✓" !important;
                font-weight: 800 !important;
                margin: 0 !important;
                padding: 0 !important;
                line-height: 1 !important;
                display: inline-block !important;
                text-align: center !important;
            }

            @keyframes iosReveal {
                0% { opacity: 0; transform: translateX(-50%) translateY(40px) scale(0.85); }
                100% { opacity: 1; transform: translateX(-50%) translateY(0) scale(1); }
            }
            @keyframes iosRotate {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        `;

        try {
            if (document.head) document.head.appendChild(style);
            if (document.body) document.body.appendChild(ui);
        } catch (e) {}

        statusEl = document.getElementById('ios-status');
        iconEl = document.getElementById('ios-spinner');
        uiEl = document.getElementById('suaurl-ios-ui');
    }

    function updateState(msg, mode = 'loading') {
        if (!uiInjected) injectUI();
        if (!statusEl) return;
        statusEl.innerHTML = msg;

        if (iconEl) {
            iconEl.className = 'ios-icon';
            iconEl.style.display = 'block';
        }
        if (uiEl) {
            uiEl.className = '';
            uiEl.style.pointerEvents = 'none';
            uiEl.style.borderRadius = '50px';
            uiEl.style.padding = '14px 28px';
        }

        if (mode === 'captcha') {
            if (iconEl) iconEl.classList.add('type-warning');
            if (uiEl) uiEl.classList.add('mode-captcha');
        } else if (mode === 'success') {
            if (iconEl) iconEl.classList.add('type-check');
            if (uiEl) uiEl.classList.add('mode-success');
        }
    }

    function showRetryButton(isProxy) {
        if (!statusEl) return;
        if (uiEl) uiEl.style.pointerEvents = 'auto';

        statusEl.innerHTML = `<span style="opacity: 0.9;">Fallo al conectar</span> <button id="suaurl-retry-btn" style="margin-left: 10px; background: #ffffff; color: #FF9500; border: none; padding: 5px 14px; border-radius: 14px; font-weight: 700; cursor: pointer; transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1); box-shadow: 0 4px 10px rgba(0,0,0,0.1);">Reintentar Bypass</button>`;
        iconEl.className = 'ios-icon type-warning';
        uiEl.className = 'mode-captcha';

        const retryBtn = document.getElementById('suaurl-retry-btn');
        if (!retryBtn) return;

        retryBtn.onmouseover = () => retryBtn.style.transform = 'scale(1.05) translateY(-1px)';
        retryBtn.onmouseout = () => retryBtn.style.transform = 'scale(1) translateY(0)';
        retryBtn.onmousedown = () => retryBtn.style.transform = 'scale(0.95)';

        retryBtn.onclick = () => {
            if (uiEl) uiEl.style.pointerEvents = 'none';

            if (isProxy) {
                updateState('Reintentando...');
                runBlogProxy();
            } else {
                updateState('Reintentando...');
                runSuaURL();
            }
        };
    }

    function showiOSNotification() {
        if (!uiEl || !statusEl) return;

        uiEl.style.pointerEvents = 'auto';

        uiEl.style.borderRadius = '22px';
        uiEl.style.padding = '18px 24px';
        uiEl.className = 'mode-captcha';

        if (iconEl) {
            iconEl.className = 'ios-icon';
            iconEl.style.display = 'none';
        }

        statusEl.innerHTML = `
            <div style="display: flex; flex-direction: column; gap: 8px; font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', sans-serif;">
                <div style="display: flex; align-items: center; gap: 8px;">
                    <span style="font-size: 16px;">💬</span>
                    <strong style="font-weight: 700; font-size: 15px; color: #ffffff; letter-spacing: -0.2px;">Mensaje de TheRealBanHammer</strong>
                </div>
                <div style="font-size: 14px; font-weight: 500; opacity: 0.95; line-height: 1.4; color: #ffffff; margin-bottom: 8px; max-width: 320px; white-space: normal;">
                    Veo que esta vaina está tardando más de lo esperado, ¿te gustaría reiniciar el bypass?
                </div>
                <div style="display: flex; gap: 10px; justify-content: flex-end;">
                    <button id="suaurl-notif-cancel" style="background: rgba(255,255,255,0.2); color: #ffffff; border: none; padding: 6px 16px; border-radius: 12px; font-weight: 600; font-size: 13px; cursor: pointer; transition: all 0.2s;">Esperar</button>
                    <button id="suaurl-notif-ok" style="background: #ffffff; color: #FF9500; border: none; padding: 6px 16px; border-radius: 12px; font-weight: 700; font-size: 13px; cursor: pointer; transition: all 0.2s; box-shadow: 0 4px 10px rgba(0,0,0,0.15);">Reiniciar</button>
                </div>
            </div>
        `;

        const okBtn = document.getElementById('suaurl-notif-ok');
        const cancelBtn = document.getElementById('suaurl-notif-cancel');

        if (okBtn) {
            okBtn.onmouseover = () => okBtn.style.transform = 'scale(1.05)';
            okBtn.onmouseout = () => okBtn.style.transform = 'scale(1)';
            okBtn.onclick = () => {
                uiEl.style.pointerEvents = 'none';
                updateState('Reiniciando bypass...');
                clearInterval(monitor);
                if (window.opener) {
                    try {
                        window.opener.postMessage({ type: 'suaurl-complete-and-refresh' }, '*');
                    } catch(e) {}
                }
                setTimeout(() => {
                    try {
                        window.close();
                    } catch(e) {}
                }, 500);
            };
        }

        if (cancelBtn) {
            cancelBtn.onmouseover = () => cancelBtn.style.transform = 'scale(1.05)';
            cancelBtn.onmouseout = () => cancelBtn.style.transform = 'scale(1)';
            cancelBtn.onclick = () => {
                startTime = Date.now();
                notificationShown = false;
                updateState('Burlando temporizador...', 'loading');
            };
        }
    }

    function hasCaptcha() {
        try {
            const captchas = document.querySelectorAll('iframe[src*="recaptcha"], iframe[src*="turnstile"], iframe[src*="hcaptcha"]');
            const hasIframeCaptcha = Array.from(captchas).some(iframe => {
                const rect = iframe.getBoundingClientRect();
                const isVisible = iframe.offsetParent !== null && rect.width > 20 && rect.height > 20;
                const style = window.getComputedStyle(iframe);
                return isVisible && style.visibility !== 'hidden' && style.opacity !== '0';
            });

            const text = document.body ? document.body.innerText.toLowerCase() : '';
            const hasSliderCaptcha = text.includes('você é um robô') || text.includes('quebra-cabeça') || text.includes('deslize para');

            return hasIframeCaptcha || hasSliderCaptcha;
        } catch (e) {
            return false;
        }
    }

    function findButton(texts) {
        try {
            return Array.from(document.querySelectorAll('button, a.btn, .btn, a.bg-primary')).find(el => {
                if (el.offsetParent === null) return false;
                if (el.disabled) return false;

                const rect = el.getBoundingClientRect();
                if (rect.width < 5 || rect.height < 5) return false;

                const style = window.getComputedStyle(el);
                if (style.opacity < 0.5 || style.pointerEvents === 'none' || style.cursor === 'not-allowed' || style.display === 'none' || style.visibility === 'hidden') return false;

                const t = (el.innerText || el.value || '').toUpperCase();
                return texts.some(x => t.includes(x));
            });
        } catch (e) {
            return null;
        }
    }

    function isTimerRunning() {
        try {
            const txt = document.body ? document.body.innerText.toLowerCase() : '';
            const match = txt.match(/aguarde mais (\d+)s/);
            if (match && parseInt(match[1]) > 0) return true;
            return false;
        } catch (e) {
            return false;
        }
    }

    function triggerSuaURLClick(btn) {
        if (!btn) return false;

        try {
            const events = ['mousedown', 'mouseup', 'click'];
            events.forEach(evtType => {
                const evt = new MouseEvent(evtType, {
                    bubbles: true,
                    cancelable: true,
                    view: window
                });
                btn.dispatchEvent(evt);
            });
            return true;
        } catch (e) {}

        try {
            const reactKey = Object.keys(btn).find(k => k.startsWith('__reactProps$'));
            if (reactKey && btn[reactKey].onClick) {
                btn[reactKey].onClick({ preventDefault: () => {}, stopPropagation: () => {} });
                return true;
            }
        } catch (e) {}

        try {
            btn.click();
            return true;
        } catch (e) {
            return false;
        }
    }

    function triggerProxyClick(btn) {
        if (!btn) return false;

        try {
            const events = ['mousedown', 'mouseup', 'click'];
            events.forEach(evtType => {
                const evt = new MouseEvent(evtType, {
                    bubbles: true,
                    cancelable: true,
                    view: window
                });
                btn.dispatchEvent(evt);
            });
            return true;
        } catch (e) {}

        try {
            btn.click();
            return true;
        } catch (e) {
            return false;
        }
    }

    function runSuaURL() {
        updateState('Saltando página inicial...');
        let attempts = 0;

        const text = document.body ? document.body.innerText : '';
        const isSecondStage = text.includes('2/2') || text.includes('2 / 2') || findButton(['ABRIR URL']);
        const maxClicks = isSecondStage ? 2 : 5;

        const clicker = setInterval(() => {
            if (hasCaptcha()) {
                updateState('Resuelve el Captcha, por favor', 'captcha');
                attempts = 0;
                return;
            }

            const btn = document.querySelector('.bg-primary, button.btn-primary') || findButton(['INICIAR', 'BUSCAR LINK', 'ABRIR URL']);
            if (btn && !btn.disabled) {
                if (attempts >= maxClicks) {
                    clearInterval(clicker);
                    updateState('Aguardando redirección...');

                    if (isSecondStage) {
                        if (window.opener) {
                            try {
                                window.opener.postMessage({ type: 'suaurl-complete-and-refresh' }, '*');
                            } catch(e) {}
                        }
                    }

                    setTimeout(() => {
                        if (document.body && !hasCaptcha()) {
                            showRetryButton(false);
                        }
                    }, 8000);
                    return;
                }

                updateState('Iniciando Bypass...');
                triggerSuaURLClick(btn);
                attempts++;
            }
        }, 1200);
    }

    function runBlogProxy() {
        updateState('Burlando temporizador...');
        let adSimulated = false;
        let attempts = 0;
        let startTime = Date.now();
        let notificationShown = false;

        function showiOSNotification() {
            if (!uiEl || !statusEl) return;

            uiEl.style.pointerEvents = 'auto';

            uiEl.style.borderRadius = '22px';
            uiEl.style.padding = '18px 24px';
            uiEl.className = 'mode-captcha';

            if (iconEl) {
                iconEl.className = 'ios-icon';
                iconEl.style.display = 'none';
            }

            statusEl.innerHTML = `
                <div style="display: flex; flex-direction: column; gap: 8px; font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', sans-serif;">
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <span style="font-size: 16px;">💬</span>
                        <strong style="font-weight: 700; font-size: 15px; color: #ffffff; letter-spacing: -0.2px;">Mensaje de TheRealBanHammer</strong>
                    </div>
                    <div style="font-size: 14px; font-weight: 500; opacity: 0.95; line-height: 1.4; color: #ffffff; margin-bottom: 8px; max-width: 320px; white-space: normal;">
                        Veo que esta vaina está tardando más de lo esperado, ¿te gustaría reiniciar el bypass?
                    </div>
                    <div style="display: flex; gap: 10px; justify-content: flex-end;">
                        <button id="suaurl-notif-cancel" style="background: rgba(255,255,255,0.2); color: #ffffff; border: none; padding: 6px 16px; border-radius: 12px; font-weight: 600; font-size: 13px; cursor: pointer; transition: all 0.2s;">Esperar</button>
                        <button id="suaurl-notif-ok" style="background: #ffffff; color: #FF9500; border: none; padding: 6px 16px; border-radius: 12px; font-weight: 700; font-size: 13px; cursor: pointer; transition: all 0.2s; box-shadow: 0 4px 10px rgba(0,0,0,0.15);">Reiniciar</button>
                    </div>
                </div>
            `;

            const okBtn = document.getElementById('suaurl-notif-ok');
            const cancelBtn = document.getElementById('suaurl-notif-cancel');

            if (okBtn) {
                okBtn.onmouseover = () => okBtn.style.transform = 'scale(1.05)';
                okBtn.onmouseout = () => okBtn.style.transform = 'scale(1)';
                okBtn.onclick = () => {
                    uiEl.style.pointerEvents = 'none';
                    updateState('Reiniciando bypass...');
                    clearInterval(monitor);
                    if (window.opener) {
                        try {
                            window.opener.postMessage({ type: 'suaurl-complete-and-refresh' }, '*');
                        } catch(e) {}
                    }
                    setTimeout(() => {
                        try {
                            window.close();
                        } catch(e) {}
                    }, 500);
                };
            }

            if (cancelBtn) {
                cancelBtn.onmouseover = () => cancelBtn.style.transform = 'scale(1.05)';
                cancelBtn.onmouseout = () => cancelBtn.style.transform = 'scale(1)';
                cancelBtn.onclick = () => {
                    startTime = Date.now();
                    notificationShown = false;
                    updateState('Burlando temporizador...', 'loading');
                };
            }
        }

        const monitor = setInterval(() => {
            if (!adSimulated) {
                try {
                    const adEl = document.querySelector('#ADs-1 a, #ADs-1 iframe, a:has(img[alt="Publicidade"]), a[href*="suastore"]');
                    if (adEl) {
                        adSimulated = true;
                        adEl.focus();
                        window.dispatchEvent(new Event('blur'));
                        updateState('Temporizador activado...');
                    }
                } catch(e) {}
            }

            const finalBtn = findButton(['PULAR CAPTCHA', 'OBTER LINK', 'CONTINUAR', 'PULAR', 'DESBLOQUEAR']);

            if (finalBtn) {
                if (hasCaptcha()) {
                    updateState('Bypass listo! Resuelve el captcha', 'captcha');
                    attempts = 0;

                    if (window.opener) {
                        try {
                            window.opener.postMessage({ type: 'suaurl-close-ads-only' }, '*');
                        } catch(e) {}
                    }
                    return;
                }

                if (isTimerRunning()) {
                    updateState('Esperando contador...', 'loading');
                    return;
                }

                if (attempts >= 2) {
                    clearInterval(monitor);
                    if (window.opener) {
                        try {
                            window.opener.postMessage({ type: 'suaurl-complete-and-refresh' }, '*');
                        } catch(e) {}
                    }
                    setTimeout(() => {
                        try {
                            window.close();
                        } catch(e) {}
                    }, 500);
                    return;
                }

                updateState('¡Bypass listo!', 'success');
                setTimeout(() => triggerProxyClick(finalBtn), 100);
                attempts++;
            } else {
                if (!hasCaptcha() && (Date.now() - startTime > 15000)) {
                    if (!notificationShown) {
                        notificationShown = true;
                        showiOSNotification();
                    }
                }
            }
        }, 1000);
    }

    const initializer = setInterval(() => {
        if (document.body && document.head && document.readyState !== 'loading') {
            clearInterval(initializer);

            const isBlogProxy = checkIsProxy();
            const isSuaURLHost = checkIsSuaURL();

            if (isBlogProxy) {
                injectUI();
                setTimeout(() => runBlogProxy(), 800);
            } else if (isSuaURLHost) {
                injectUI();
                setTimeout(() => runSuaURL(), 800);
            } else if (window.isOpenedBySuaURL) {
                try {
                    window.close();
                } catch(e) {}
            }
        }
    }, 100);

})();
