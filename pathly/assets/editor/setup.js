// Basic Editor Logic mimicking Monaco interactions
const codeInput = document.getElementById('code-input');
const codeRender = document.getElementById('code-render');
const lineNumbers = document.getElementById('line-numbers');

// Communication Bridge
function sendMessage(type, payload) {
    if (window.EditorChannel) {
        window.EditorChannel.postMessage(JSON.stringify({ type, payload }));
    }
}

// Simple Dart Syntax Highlighter (Regex based)
function highlight(code) {
    let html = code
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");

    // Keywords
    html = html.replace(/\b(void|int|double|String|bool|var|final|const|class|return|if|else|for|while|import|show|as)\b/g, '<span class="keyword">$1</span>');
    // Strings
    html = html.replace(/(".*?"|'.*?')/g, '<span class="string">$1</span>');
    // Comments
    html = html.replace(/(\/\/.*)/g, '<span class="comment">$1</span>');
    // Functions
    html = html.replace(/\b([a-zA-Z_]\w*)\s*(?=\()/g, '<span class="function">$1</span>');
    // Numbers
    html = html.replace(/\b(\d+)\b/g, '<span class="number">$1</span>');

    return html;
}

function update() {
    const code = codeInput.value;
    codeRender.innerHTML = highlight(code) + '<br>'; // Add break to ensure last line visibility
    updateLineNumbers(code);
    sendMessage('CodeChanged', code);
}

function updateLineNumbers(code) {
    const lines = code.split('\n').length;
    lineNumbers.innerHTML = Array(lines).fill(0).map((_, i) => i + 1).join('<br>');
}

function syncScroll() {
    codeRender.scrollTop = codeInput.scrollTop;
    codeRender.scrollLeft = codeInput.scrollLeft;
    lineNumbers.scrollTop = codeInput.scrollTop;
}

// Event Listeners
codeInput.addEventListener('input', update);
codeInput.addEventListener('scroll', syncScroll);
codeInput.addEventListener('keydown', (e) => {
    if (e.key === 'Tab') {
        e.preventDefault();
        const start = this.selectionStart;
        const end = this.selectionEnd;
        // Insert 2 spaces
        this.value = this.value.substring(0, start) + "  " + this.value.substring(end);
        this.selectionStart = this.selectionEnd = start + 2;
        update();
    }
});

// External API (Called from Flutter)
window.setCode = function (code) {
    codeInput.value = code;
    update();
}

// Initialize
sendMessage('EditorReady', {});
