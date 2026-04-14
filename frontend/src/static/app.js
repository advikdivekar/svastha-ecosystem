// Mark active nav link
document.querySelectorAll("nav a").forEach(a => {
    if (a.href === location.href) a.classList.add("active");
});

// Render a table from array of objects
function renderTable(containerId, rows, columns) {
    const el = document.getElementById(containerId);
    if (!rows || rows.length === 0) {
        el.innerHTML = `<div class="empty">No data found</div>`;
        return;
    }
    const cols = columns || Object.keys(rows[0]);
    const thead = cols.map(c =>
        `<th>${c.replace(/_/g, " ").toUpperCase()}</th>`
    ).join("");
    const tbody = rows.map(r =>
        `<tr>${cols.map(c => `<td>${r[c] ?? "—"}</td>`).join("")}</tr>`
    ).join("");
    el.innerHTML = `
    <div class="table-wrap">
      <table>
        <thead><tr>${thead}</tr></thead>
        <tbody>${tbody}</tbody>
      </table>
    </div>`;
}

// Risk badge
function riskBadge(score) {
    if (score >= 70) return `<span class="badge badge-red">${score} High</span>`;
    if (score >= 40) return `<span class="badge badge-orange">${score} Medium</span>`;
    return `<span class="badge badge-green">${score} Low</span>`;
}

// Risk bar fill color
function riskColor(score) {
    if (score >= 70) return "#ff5b5b"; // Brutalist Red
    if (score >= 40) return "#ffbd3a"; // Brutalist Orange
    return "#1cdb94"; // Brutalist Green
}

// Status badge
function statusBadge(status) {
    const map = {
        Delivered: "badge-green",
        Completed: "badge-green",
        Confirmed: "badge-blue",
        Scheduled: "badge-blue",
        Shipped: "badge-blue",
        Pending: "badge-orange",
        Cancelled: "badge-red",
    };
    return `<span class="badge ${map[status] || "badge-gray"}">${status}</span>`;
}

// Stock badge
function stockBadge(status) {
    const map = {
        "Well Stocked": "badge-green",
        "Moderate": "badge-blue",
        "Low Stock": "badge-orange",
        "Out of Stock": "badge-red",
    };
    return `<span class="badge ${map[status] || "badge-gray"}">${status}</span>`;
}

// Loading spinner
function setLoading(id, msg = "Loading...") {
    document.getElementById(id).innerHTML =
        `<div class="loading">${msg}</div>`;
}

// Show error
function setError(id, msg = "Failed to load data") {
    document.getElementById(id).innerHTML =
        `<div class="empty" style="color:#dc2626">${msg}</div>`;
}

// Truncate long strings
function trunc(str, n = 30) {
    return str && str.length > n ? str.slice(0, n) + "…" : str ?? "—";
}