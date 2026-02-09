# FINAL CAPABILITY vs ACCESSIBILITY AUDIT REPORT

**Date:** 2024-05-20  
**Status:** 4 ORPHANS DETECTED  
**Auditor:** Jules (Senior Code Auditor)

---

## AUDIT TABLE

| FEATURE NAME | CODE STATUS | UI ACCESS |
| :--- | :--- | :--- |
| **Generate Concierge Contract** | ✅ `EcoPdfService.generateContratConcierge` | ✅ Linked (`AdministrativeHubScreen`) |
| **Generate Mise En Demeure** | ✅ `EcoPdfService.generateMiseEnDemeure` | ✅ Linked (`AdministrativeHubScreen`) |
| **Generate Receipt (Quittance)** | ✅ `EcoPdfService.generateReceipt` | ✅ Linked (`AdministrativeHubScreen`) |
| **Generate Appel de Fonds** | ✅ `EcoPdfService.generateAppelDeFonds` | ✅ Linked (`AdministrativeHubScreen`) |
| **Generate Global Matrix** | ✅ `EcoPdfService.generateGlobalMatrix` | ✅ Linked (`AdministrativeHubScreen`) |
| **Generate Pouvoir (Proxy)** | ✅ `EcoPdfService.generatePouvoir` | ✅ Linked (`AdministrativeHubScreen`) |
| **Generate Decharge Logement** | ✅ `EcoPdfService.generateDechargeLogement` | ✅ Linked (`AdministrativeHubScreen`) |
| **Generate PV AG** | ✅ `EcoPdfService.generatePV` | ✅ Linked (`MeetingLiveScreen`) |
| **Generate Bulletin Paie** | ✅ `EcoPdfService.generateBulletinPaieConcierge` | ✅ Linked (`AdministrativeHubScreen`) |
| **Generate Convocation AG** | ✅ `EcoPdfService.generateConvocationAG` | ⚠️ **MISMATCH:** UI uses legacy `PdfService`. |
| **Generate Consentement Digital** | ✅ `EcoPdfService.generateConsentementDigital` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Bon de Commande** | ✅ `EcoPdfService.generateBonDeCommande` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Reçu Ménage** | ✅ `EcoPdfService.generateRecuPrestationMenage` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Journal Caisse** | ✅ `EcoPdfService.generateJournalCaisse` | ⛔ **ORPHANED / UNREACHABLE** |

---

## PROPOSED FIXES

### 1. Convocation AG (Upgrade)
*   **File:** `lib/features/dashboard/presentation/convocation_dialog.dart`
*   **Fix:** Switch `PdfService` to `EcoPdfService`. Update method call to `generateConvocationAG`.

### 2. Consentement Digital (WhatsApp)
*   **File:** `lib/features/legal/presentation/legal_docs_screen.dart` (AdministrativeHubScreen)
*   **Fix:** Add Button [ 📱 Consentement Digital ] in JURIDIQUE Category.

### 3. Bon de Commande
*   **File:** `lib/features/transactions/presentation/transaction_entry_screen.dart`
*   **Fix:** If "Dépense" is selected, add a Button [ 🧾 Créer Bon de Commande ] next to the "Enregistrer" button.

### 4. Reçu Ménage
*   **File:** `lib/features/legal/presentation/legal_docs_screen.dart` (AdministrativeHubScreen)
*   **Fix:** Add Button [ 🧹 Reçu Ménage ] in GESTION RH Category.

### 5. Journal Caisse
*   **File:** `lib/features/legal/presentation/legal_docs_screen.dart` (AdministrativeHubScreen)
*   **Fix:** Add Button [ 💰 Journal de Caisse ] in GESTION FINANCIÈRE Category.
