# 🐍 Python Switch — Windows Python Version Manager (Batch)

`python-switch.bat` is a simple Windows batch utility that allows you to **switch your default Python version** by reordering your **user PATH** safely.  
It can also update the **Python Launcher (`py`)** default version when needed.

---

## ⚙️ Features

✅ Switch between multiple Python installations (2.7, 3.12, 3.13, etc.)  
✅ Automatically updates your user PATH — no admin rights required  
✅ Optional `--py` flag updates the Python Launcher (`py.ini`)  
✅ Includes convenience shortcuts like `use27`, `use312`, `use313`  
✅ Safe (does not modify system-wide PATH)  
✅ Easily revert to another version anytime

---

## 🧩 Installation

1. Copy `python-switch.bat` to a folder that’s on your **user PATH**, for example:
   ```
   C:\Users\<YourName>\bin\
   ```
   (You can create this folder if it doesn’t exist.)

2. Add it to your PATH if needed:
   - Windows Search → *Environment Variables* → *User Variables → Path → Edit → New*  
     Add: `C:\Users\<YourName>\bin`

3. Disable Microsoft Store aliases:
   - **Settings → Apps → Advanced app settings → App execution aliases**
   - Turn **OFF** `python.exe` and `python3.exe`.

4. (Optional) Verify that all your Pythons exist:
   ```
   C:\Python27\
   %LocalAppData%\Programs\Python\Python312\
   %LocalAppData%\Programs\Python\Python313\
   ```

---

## 🚀 Usage

### List installed versions
```cmd
python-switch list
```

### Switch to Python 2.7
```cmd
python-switch use27 --py
```

### Switch to Python 3.13
```cmd
python-switch use313 --py
```

### Switch to any custom path
```cmd
python-switch use "D:\Apps\Python311" --py
```

---

## 🔍 Verify

After switching, **open a new terminal** and run:
```cmd
python --version
py --version
```

---

## 🧱 How it works

- Reorders the **user PATH** to put `<PythonRoot>` and `<PythonRoot>\Scripts` first.
- Optionally updates `%LOCALAPPDATA%\py.ini` with:
  ```ini
  [defaults]
  python=2.7
  ```

---

## 🧑‍💻 Author

**Petre Florea** — Senior JavaScript / Python Developer  
🇷🇴 Romania — 2025

---

### License

MIT License — free to use, modify, and distribute.
