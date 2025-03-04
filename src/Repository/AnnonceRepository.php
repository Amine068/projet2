<?php

namespace App\Repository;

use App\Entity\Annonce;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Annonce>
 */
class AnnonceRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Annonce::class);
    }

    //    /**
    //     * @return Annonce[] Returns an array of Annonce objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('a')
    //            ->andWhere('a.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('a.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Annonce
    //    {
    //        return $this->createQueryBuilder('a')
    //            ->andWhere('a.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }

    // requette
    public function search(): array
    {
        return $this->createQueryBuilder('a')
            ->andWhere('a.isValidated = true')
            ->andWhere('a.isArchived = false')
            ->andWhere('a.isVisible = true')
            ->andWhere('a.isLocked = false')
            ->getQuery()
            ->getResult();
    }

    public function searchWithFilter($recherche, $categoryFilter, $subcategoryFilter, $localisation, $prixMin, $prixMax): array
    {
        $qb = $this->createQueryBuilder('a')
            ->andWhere('a.isValidated = true')
            ->andWhere('a.isArchived = false')
            ->andWhere('a.isVisible = true')
            ->andWhere('a.isLocked = false');

        if ($recherche != null) {
            $qb->andWhere('a.title LIKE :recherche');
            $qb->setParameter('recherche', '%' . $recherche . '%');
        }
        if ($categoryFilter != null) {
            $qb->andWhere('a.category = :category');
            $qb->setParameter('category', $categoryFilter);
        }
        if ($subcategoryFilter != null) {
            $qb->andWhere('a.subcategory = :subcategory');
            $qb->setParameter('subcategory', $subcategoryFilter);
        }
        if ($localisation != null) {
            $qb->andWhere('a.city = :city');
            $qb->setParameter('city', $localisation);
        }
        if ($prixMin != null) {
            $qb->andWhere('a.price >= :prixMin');
            $qb->setParameter('prixMin', $prixMin);
        }
        if ($prixMax != null) {
            $qb->andWhere('a.price <= :prixMax');
            $qb->setParameter('prixMax', $prixMax);
        }

        return $qb->getQuery()->getResult();
    }
}
