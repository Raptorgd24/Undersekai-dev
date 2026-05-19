/// scr_sing_create_test_chart()
/// Retorna un array con un chart de prueba para testing
function scr_sing_create_test_chart() {
    var chart = [
        // Estructura: { time_ms: número, lane: "D"|"F"|"J"|"K" }
        { time_ms: 500, lane: "D" },
        { time_ms: 750, lane: "F" },
        { time_ms: 1000, lane: "J" },
        { time_ms: 1250, lane: "K" },
        { time_ms: 1500, lane: "D" },
        { time_ms: 1750, lane: "F" },
        { time_ms: 2000, lane: "J" },
        { time_ms: 2250, lane: "K" },
        { time_ms: 2500, lane: "D" },
        { time_ms: 2750, lane: "F" },
        { time_ms: 3000, lane: "J" },
        { time_ms: 3250, lane: "K" },
        { time_ms: 3500, lane: "D" },
        { time_ms: 3750, lane: "F" },
        { time_ms: 4000, lane: "J" },
        { time_ms: 4250, lane: "K" },
    ];
    
    return chart;
}