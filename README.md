<img src="https://firebasestorage.googleapis.com/v0/b/tastyrecipeapp.appspot.com/o/logo%20trimmed.png?alt=media&token=206ee3ae-7354-428d-a214-ac540d0156f3" width="300">

<h1>Melodify - A Flutter Music App</h1>

<p>
  A powerful and scalable <strong>Flutter Music App</strong> developed with <strong>Clean Architecture</strong>, 
  <strong>BLoC</strong> for state management, and <strong>Dependency Injection</strong> for modular design. 
  This project follows best practices to ensure maintainability, testability, and high performance.
</p>

<h2>🧱 Architecture</h2>

<p>
  The project is based on the <strong>Clean Architecture</strong> pattern which divides the codebase into distinct layers:
</p>

<ul>
  <li><strong>Presentation Layer:</strong> Handles UI and state management with BLoC</li>
  <li><strong>Domain Layer:</strong> Contains business logic and use cases</li>
  <li><strong>Data Layer:</strong> Manages repositories and data sources (local or remote)</li>
</ul>

<h2>🛠️ Tech Stack</h2>

<ul>
  <li><strong>Flutter</strong> - Cross-platform framework</li>
  <li><strong>Dart</strong> - Programming language</li>
  <li><strong>BLoC</strong> - Reactive state management</li>
  <li><strong>GetIt</strong> - Dependency injection</li>
  <li><strong>Just Audio</strong> - Audio playback</li>
  <li><strong>Equatable</strong>, <strong>Freezed</strong> - Data modeling</li>
</ul>

<h2>📱 Features</h2>

<ul>
  <li>🎧 Audio playback: Play, pause, skip, seek</li>
  <li>📁 Browse songs by artist, playlist</li>
  <li>🔍 Search functionality</li>
  <li>🌗 Light/Dark theme switch</li>
  <li>📶 Responsive UI for all screen sizes</li>
</ul>

<h2>🚀 Getting Started</h2>

<ol>
  <li>Clone the repository:</li>
  <pre><code>git clone https://github.com/hardeepsinghpahwa/melodify_music_app.git</code></pre>
  
  <li>Navigate to the project folder:</li>
  <pre><code>cd music_app</code></pre>
  
  <li>Install dependencies:</li>
  <pre><code>flutter pub get</code></pre>
  
  <li>Run the app:</li>
  <pre><code>flutter run</code></pre>
</ol>

<h2>📂 Project Structure (Simplified)</h2>

<pre><code>lib/
├── common/             # Common Widgets, Helpers
├── core/               # Shared utilities, themes, DI
├── presentation/       # UI, widgets, BLoC
├── domain/             # Entities, use cases
└── data/               # Repositories, data sources
└── main.dart           # Entry point
</code></pre>

