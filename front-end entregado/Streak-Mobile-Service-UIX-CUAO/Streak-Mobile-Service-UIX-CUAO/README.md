# 🏠 Streak – Home Screen
> _Pantalla principal del frontend (UI) con saludo al usuario, tarjeta promocional, métricas y lista de empleos_ 🚀  

---

## 📝 Descripción
La pantalla **Home** es la primera interfaz de la app.  
Actualmente muestra:  
- El saludo dinámico con el nombre del usuario.  
- Una tarjeta promocional (`PromoCard`).  
- Tarjetas de métricas (`StatCard`).  
- Cards de empleos (`JobCard`).  
- Navegación inferior (`BottomNav`).  

---

## 📂 Estructura de archivos

- lib/
   - main.dart // Inicializa la app y pasa userName
   - screens/
        - home_screen.dart // Pantalla principal de Home
   - widgets/home/
        - promo_card.dart // Tarjeta promocional
        - stat_card.dart // Tarjetas de métricas
        - job_card.dart // Cards de empleos
   - widgets/common/
        - bottom_nav.dart // Barra de navegación inferior


---

## 🔑 Variables importantes

- **userName (String)**  
  - Se recibe desde `main.dart`.  
  - Usado en `HomeScreen` para mostrar el saludo dinámico.  
  - Ejemplo actual:  
    ```dart
    runApp(const StreakApp(userName: "Carlos"));
    ```
  - Luego se reemplazará por el nombre real del usuario al iniciar sesión.  

---

## 🧩 Componentes principales

- **`HomeScreen`**  
  - Recibe `userName` y compone la UI.  
  - Contiene la lista de secciones: saludo, promo, métricas y empleos.  

- **`PromoCard`**  
  - Tarjeta fija con un mensaje promocional.  

- **`StatCard`**  
  - Recibe `label`, `value`, `bg` y `icon`.  
  - Se usa para mostrar métricas (ejemplo: “Trabajo remoto”).  

- **`JobCard`**  
  - Recibe `title`, `company`, `salary`, `tags`.  
  - Representa una oferta de empleo en lista.  

- **`BottomNav`**  
  - Barra de navegación con iconos de Home, Search, Mensajes y Perfil.  

---

## ✅ Checklist de Home

- [x] Saludo con nombre dinámico (`userName`).  
- [x] Estructura de UI con widgets separados.  
- [x] Navegación inferior incluida.  
- [ ] Conectar datos reales desde backend (pendiente).  