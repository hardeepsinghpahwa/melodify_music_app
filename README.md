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
  <pre><code>cd melodify_music_app</code></pre>
  
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

<h2>📂 Sceenshots</h2>

<p align="center">
  <img src="https://firebasestorage.googleapis.com/v0/b/tastyrecipeapp.appspot.com/o/Screenshot_20250421_203827.png?alt=media&token=4d6f9902-277d-48b9-8d49-e9a96c1c58ba" width="150" />
  <img src="https://firebasestorage.googleapis.com/v0/b/tastyrecipeapp.appspot.com/o/Screenshot_20250421_203835.png?alt=media&token=84b82963-8237-45aa-a24f-3d58ad74ad38" width="150" />
  <img src="https://firebasestorage.googleapis.com/v0/b/tastyrecipeapp.appspot.com/o/Screenshot_20250421_203754.png?alt=media&token=151d36e9-4574-4d51-9e12-ebbd96665d8a" width="150" />
 <img src="https://firebasestorage.googleapis.com/v0/b/tastyrecipeapp.appspot.com/o/Screenshot_20250421_203931.png?alt=media&token=b9ca9b8f-94b1-471d-a07a-c7cc17264585" width="150" />
</p>

