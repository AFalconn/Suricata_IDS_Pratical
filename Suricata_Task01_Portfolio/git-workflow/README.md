# Git Workflow

## Initialize

```bash
git init
git branch -M main
```

## Check files

```bash
git status
```

## Stage

```bash
git add .
```

## Commit

```bash
git commit -m "Add Suricata Task 01 portfolio lab"
```

## Connect remote

```bash
git remote add origin https://github.com/AFalconn/Suricata_Task01.git
```

If a remote already exists:

```bash
git remote -v
```

## Push

```bash
git push -u origin main
```

## Future updates

```bash
git add .
git commit -m "Update Suricata lab evidence"
git push
```

Do not commit passwords, API keys, private keys, or sensitive system information.
