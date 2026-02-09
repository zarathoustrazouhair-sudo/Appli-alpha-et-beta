# CAPABILITY vs ACCESSIBILITY AUDIT REPORT

**Date:** 2024-05-20  
**Status:** DETECTED 9 ORPHANED FEATURES  
**Auditor:** Jules (Senior Code Auditor)

---

## AUDIT TABLE

| FEATURE NAME | CODE STATUS | UI ACCESS |
| :--- | :--- | :--- |
| **Generate Concierge Contract (CDI)** | ✅ `EcoPdfService.generateContratConcierge` | ✅ Linked (`LegalDocsScreen` FAB) |
| **Generate Mise En Demeure** | ✅ `EcoPdfService.generateMiseEnDemeure` | ✅ Linked (`LegalDocsScreen` Tile) |
| **Generate Receipt (Quittance)** | ✅ `EcoPdfService.generateReceipt` | ✅ Linked (`TransactionsHistoryScreen`) |
| **Generate PV AG** | ✅ `EcoPdfService.generatePV` | ✅ Linked (`MeetingLiveScreen`) |
| **Generate Convocation AG** | ✅ `EcoPdfService.generateConvocationAG` | ⚠️ **MISMATCH:** UI uses legacy `PdfService.generateConvocation`. |
| **Generate Appel de Fonds** | ✅ `EcoPdfService.generateAppelDeFonds` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Pouvoir (Proxy)** | ✅ `EcoPdfService.generatePouvoir` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Decharge Logement** | ✅ `EcoPdfService.generateDechargeLogement` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Consentement Digital** | ✅ `EcoPdfService.generateConsentementDigital` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Bon de Commande** | ✅ `EcoPdfService.generateBonDeCommande` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Bulletin Paie** | ✅ `EcoPdfService.generateBulletinPaieConcierge` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Reçu Ménage** | ✅ `EcoPdfService.generateRecuPrestationMenage` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Journal Caisse** | ✅ `EcoPdfService.generateJournalCaisse` | ⛔ **ORPHANED / UNREACHABLE** |
| **Generate Global Matrix (Tableau)**| ✅ `EcoPdfService.generateGlobalMatrix` | ⚠️ **MISMATCH:** UI uses legacy `generateGlobalReport`. |

---

## PROPOSED FIXES FOR ORPHANS

### 1. Convocation AG (Upgrade)
*   **File:** `lib/features/dashboard/presentation/convocation_dialog.dart`
*   **Fix:** Switch `PdfService` to `EcoPdfService`. Update method call to `generateConvocationAG`.

### 2. Appel de Fonds & Consentement & Pouvoir
*   **File:** `lib/features/residents/presentation/resident_detail_screen.dart`
*   **Fix:** Add an "Actions Administratives" PopupMenu in the AppBar:
    *   [ 📨 Appel de Fonds ]
    *   [ ✍️ Pouvoir ]
    *   [ 📱 Consentement Digital ]

### 3. Decharge Logement (Anti-Squat)
*   **File:** `lib/features/legal/presentation/legal_docs_screen.dart`
*   **Fix:** Inside the `_showCreateContractDialog` (already exists), add a Checkbox "Générer Décharge Logement" that calls `generateDechargeLogement` immediately after contract generation.

### 4. Bon de Commande
*   **File:** `lib/features/transactions/presentation/transaction_entry_screen.dart`
*   **Fix:** If "Dépense" is selected, add a Button [ 🧾 Créer Bon de Commande ] next to the "Enregistrer" button.

### 5. Staff Docs (Bulletin Paie / Reçu Ménage)
*   **File:** `lib/features/providers/presentation/provider_list_screen.dart`
*   **Fix:** Add "Documents" icon on Provider tile.
    *   If Provider Job = "Concierge" -> Show [ 📄 Bulletin Paie ].
    *   If Provider Job = "Ménage" -> Show [ 🧹 Reçu Prestation ].

### 6. Journal Caisse & Global Matrix
*   **File:** `lib/features/dashboard/presentation/dashboard_screen_optimized.dart`
*   **Fix:** In the `_LegalDrawer` (or create a `ReportsDrawer`), add:
    *   [ 📊 Tableau Annuel (Matrix) ] -> Calls `generateGlobalMatrix`.
    *   [ 💰 Journal de Caisse ] -> Calls `generateJournalCaisse`.
