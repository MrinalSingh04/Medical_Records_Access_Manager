# 🏥 Medical Records Access Manager

A decentralized smart contract that empowers patients to securely manage and share access to their medical records using blockchain-based permission control.

---
 
## ✅ What is this?
 
This is a Solidity smart contract that allows:

- Patients to store hashes of their medical records (stored on IPFS or similar).
- Control who (doctors, institutions) can view their records.
- Grant and revoke access anytime. 
- Optionally, grant time-limited access (e.g., 7 days).

All actions are logged via events and are publicly verifiable.

--- 

## 🎯 Why this?

Medical records are sensitive and often fragmented across systems. Traditional healthcare platforms:

- Lack interoperability.
- Can be breached or misused.
- Offer poor patient ownership over data.

By putting **access control** on-chain and storing the **record hash off-chain**, we ensure:

- **Privacy**: Data is not stored on-chain.
- **Transparency**: Access grants/revokes are traceable.
- **Decentralization**: Patient owns their data, not a hospital or app.

This contract can plug into dApps, wallets, or health-tech portals.

---

## ⚙️ How it works

- `addRecord(ipfsHash)`: Store a new medical record's hash.
- `grantAccess(doctor, duration)`: Allow a doctor access for a fixed time.
- `revokeAccess(doctor)`: Revoke access before it expires.
- `getRecords(patient)`: Only callable by the patient or an authorized doctor.

---

## 📄 License

MIT — free to use, modify, and extend with credit.
