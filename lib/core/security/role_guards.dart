enum UserRole {
  admin,
  syndic,
  adjoint,
  resident,
  concierge,
}

class RoleGuards {
  static bool canEditFinance(UserRole role) {
    return role == UserRole.admin || role == UserRole.syndic;
  }

  static bool isSyndicOrAdmin(UserRole role) {
    return role == UserRole.admin || role == UserRole.syndic || role == UserRole.adjoint;
  }

  static bool isResident(UserRole role) {
    return role == UserRole.resident;
  }

  static bool isConcierge(UserRole role) {
    return role == UserRole.concierge;
  }
}
