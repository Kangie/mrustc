/*
 */
#pragma once

namespace HIR {
    class Crate;
};

extern void HIR_Expand_AnnotateUsage(::HIR::Crate& crate);
extern void HIR_Expand_Closures(::HIR::Crate& crate);
extern void HIR_Expand_UfcsEverything(::HIR::Crate& crate);
extern void HIR_Expand_Reborrows(::HIR::Crate& crate);
