shader_type canvas_item;
render_mode blend_add; // Isso garante que a luz some com a escuridão

// Configurações que vão aparecer no Inspector
uniform float angle_width : hint_range(0.0, 180.0) = 45.0; // Abertura do cone
uniform float smoothness : hint_range(0.0, 1.0) = 0.1; // Suavidade das bordas
uniform float fade_start : hint_range(0.0, 1.0) = 0.3; // Onde começa a sumir (perto da mão)
uniform float fade_end : hint_range(0.0, 1.0) = 1.0;   // Onde termina de sumir (longe)

void fragment() {
	// Centraliza as coordenadas (0,0 passa a ser o centro da imagem)
	vec2 uv = UV - 0.5;

	// Calcula o ângulo do pixel atual em relação ao centro
	// No Godot, angulo 0 é para a direita (Eixo X positivo)
	float angle = degrees(atan(uv.y, uv.x));

	// Calcula a distância do centro
	float dist = length(uv) * 2.0;

	// --- LÓGICA DO CONE ---

	// 1. Corte Angular (Forma de fatia de pizza)
	// Usamos smoothstep para a borda do cone não ser serrilhada
	float angle_mask = 1.0 - smoothstep(angle_width - (angle_width * smoothness), angle_width, abs(angle));

	// 2. Corte de Distância (Fade out no final)
	float dist_mask = 1.0 - smoothstep(fade_start, fade_end, dist);

	// Combina as duas máscaras
	float final_alpha = angle_mask * dist_mask;

	// Aplica na cor da luz
	COLOR = texture(TEXTURE, UV); // Pega a cor base da luz
	COLOR.a *= final_alpha;       // Aplica a transparência calculada
}